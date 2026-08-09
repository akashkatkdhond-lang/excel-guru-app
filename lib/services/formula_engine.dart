import 'dart:math' as math;

/// A tiny spreadsheet engine that powers the "Practice Simulator" screen.
///
/// Supports:
///   - Arithmetic: + - * / ^ and parentheses
///   - Comparisons: = <> < > <= >=
///   - Cell references (A1) and ranges (A1:A5)
///   - Functions: SUM AVERAGE MIN MAX COUNT IF AND OR NOT
///
/// This is intentionally a learning-focused subset of real Excel — enough
/// for beginners to *practice* formulas, not a full spreadsheet engine.
class FormulaEngine {
  FormulaEngine(this.grid);

  /// Raw text the user typed into each cell, e.g. {"A1": "10", "B1": "=A1*2"}
  final Map<String, String> grid;

  final Set<String> _evaluating = {};
  final Map<String, dynamic> _cache = {};

  /// Clears cached results — call whenever [grid] changes.
  void invalidate() => _cache.clear();

  /// Public entry point: evaluate whatever is currently stored in [cellId].
  dynamic valueOf(String cellId) {
    if (_cache.containsKey(cellId)) return _cache[cellId];
    final raw = grid[cellId]?.trim() ?? '';
    if (raw.isEmpty) {
      _cache[cellId] = '';
      return '';
    }
    if (!raw.startsWith('=')) {
      final n = num.tryParse(raw);
      final result = n ?? raw;
      _cache[cellId] = result;
      return result;
    }
    if (_evaluating.contains(cellId)) {
      return '#CIRCULAR!';
    }
    _evaluating.add(cellId);
    try {
      final tokens = _tokenize(raw.substring(1));
      final parser = _Parser(tokens, this);
      final result = parser.parseExpression();
      parser.expectEnd();
      _cache[cellId] = result;
      return result;
    } catch (e) {
      final err = e is _FormulaException ? e.message : '#ERROR!';
      _cache[cellId] = err;
      return err;
    } finally {
      _evaluating.remove(cellId);
    }
  }

  /// Expands a range like A1:B3 into a flat list of cell values (row-major).
  List<dynamic> rangeValues(String startCell, String endCell) {
    final start = _parseCellId(startCell);
    final end = _parseCellId(endCell);
    final values = <dynamic>[];
    for (var col = start.col; col <= end.col; col++) {
      for (var row = start.row; row <= end.row; row++) {
        values.add(valueOf(_cellIdFrom(col, row)));
      }
    }
    return values;
  }

  static _CellCoord _parseCellId(String id) {
    final match = RegExp(r'^([A-Za-z]+)(\d+)$').firstMatch(id);
    if (match == null) throw const _FormulaException('#REF!');
    final letters = match.group(1)!.toUpperCase();
    final row = int.parse(match.group(2)!);
    var col = 0;
    for (var i = 0; i < letters.length; i++) {
      col = col * 26 + (letters.codeUnitAt(i) - 64);
    }
    return _CellCoord(col, row);
  }

  static String _cellIdFrom(int col, int row) {
    var c = col;
    var letters = '';
    while (c > 0) {
      final rem = (c - 1) % 26;
      letters = String.fromCharCode(65 + rem) + letters;
      c = (c - 1) ~/ 26;
    }
    return '$letters$row';
  }
}

class _CellCoord {
  final int col;
  final int row;
  const _CellCoord(this.col, this.row);
}

class _FormulaException implements Exception {
  final String message;
  const _FormulaException(this.message);
}

// ---------------- Tokenizer ----------------

enum _TokType { number, string, ident, op, lparen, rparen, comma, colon, end }

class _Token {
  final _TokType type;
  final String text;
  const _Token(this.type, this.text);
}

List<_Token> _tokenize(String input) {
  final tokens = <_Token>[];
  var i = 0;
  while (i < input.length) {
    final c = input[i];
    if (c == ' ' || c == '\t') {
      i++;
      continue;
    }
    if (c == '(') {
      tokens.add(const _Token(_TokType.lparen, '('));
      i++;
    } else if (c == ')') {
      tokens.add(const _Token(_TokType.rparen, ')'));
      i++;
    } else if (c == ',') {
      tokens.add(const _Token(_TokType.comma, ','));
      i++;
    } else if (c == ':') {
      tokens.add(const _Token(_TokType.colon, ':'));
      i++;
    } else if (c == '"') {
      final buf = StringBuffer();
      i++;
      while (i < input.length && input[i] != '"') {
        buf.write(input[i]);
        i++;
      }
      i++; // closing quote
      tokens.add(_Token(_TokType.string, buf.toString()));
    } else if ('+-*/^'.contains(c)) {
      tokens.add(_Token(_TokType.op, c));
      i++;
    } else if (c == '<' || c == '>' || c == '=') {
      var op = c;
      i++;
      if (i < input.length &&
          ((c == '<' && (input[i] == '=' || input[i] == '>')) ||
              (c == '>' && input[i] == '='))) {
        op += input[i];
        i++;
      }
      tokens.add(_Token(_TokType.op, op));
    } else if (RegExp(r'[0-9.]').hasMatch(c)) {
      final start = i;
      while (i < input.length && RegExp(r'[0-9.]').hasMatch(input[i])) {
        i++;
      }
      tokens.add(_Token(_TokType.number, input.substring(start, i)));
    } else if (RegExp(r'[A-Za-z_]').hasMatch(c)) {
      final start = i;
      while (i < input.length && RegExp(r'[A-Za-z0-9_]').hasMatch(input[i])) {
        i++;
      }
      tokens.add(_Token(_TokType.ident, input.substring(start, i)));
    } else if (c == r'$') {
      // Absolute-reference marker (e.g. $A$1) — ignore, treat as relative.
      i++;
    } else {
      throw const _FormulaException('#ERROR!');
    }
  }
  tokens.add(const _Token(_TokType.end, ''));
  return tokens;
}

// ---------------- Parser / Evaluator ----------------

class _Parser {
  _Parser(this.tokens, this.engine);

  final List<_Token> tokens;
  final FormulaEngine engine;
  int pos = 0;

  _Token get _cur => tokens[pos];

  void expectEnd() {
    if (_cur.type != _TokType.end) throw const _FormulaException('#ERROR!');
  }

  _Token _advance() {
    final t = _cur;
    if (pos < tokens.length - 1) pos++;
    return t;
  }

  dynamic parseExpression() => _parseComparison();

  dynamic _parseComparison() {
    var left = _parseTerm();
    while (_cur.type == _TokType.op &&
        ['=', '<>', '<', '>', '<=', '>='].contains(_cur.text)) {
      final op = _advance().text;
      final right = _parseTerm();
      left = _compare(left, right, op);
    }
    return left;
  }

  dynamic _parseTerm() {
    var left = _parseFactor();
    while (_cur.type == _TokType.op && (_cur.text == '+' || _cur.text == '-')) {
      final op = _advance().text;
      final right = _parseFactor();
      left = op == '+' ? _num(left) + _num(right) : _num(left) - _num(right);
    }
    return left;
  }

  dynamic _parseFactor() {
    var left = _parseUnary();
    while (_cur.type == _TokType.op && (_cur.text == '*' || _cur.text == '/')) {
      final op = _advance().text;
      final right = _parseUnary();
      if (op == '/') {
        final divisor = _num(right);
        if (divisor == 0) throw const _FormulaException('#DIV/0!');
        left = _num(left) / divisor;
      } else {
        left = _num(left) * _num(right);
      }
    }
    return left;
  }

  dynamic _parseUnary() {
    if (_cur.type == _TokType.op && _cur.text == '-') {
      _advance();
      return -_num(_parseUnary());
    }
    return _parsePower();
  }

  dynamic _parsePower() {
    final base = _parsePrimary();
    if (_cur.type == _TokType.op && _cur.text == '^') {
      _advance();
      final exp = _parseUnary();
      return _pow(_num(base), _num(exp));
    }
    return base;
  }

  dynamic _parsePrimary() {
    final t = _cur;
    if (t.type == _TokType.number) {
      _advance();
      return num.parse(t.text);
    }
    if (t.type == _TokType.string) {
      _advance();
      return t.text;
    }
    if (t.type == _TokType.lparen) {
      _advance();
      final v = parseExpression();
      if (_cur.type != _TokType.rparen) throw const _FormulaException('#ERROR!');
      _advance();
      return v;
    }
    if (t.type == _TokType.ident) {
      final name = t.text.toUpperCase();
      _advance();
      if (_cur.type == _TokType.lparen) {
        return _parseFunctionCall(name);
      }
      if (RegExp(r'^[A-Za-z]+\d+$').hasMatch(name)) {
        if (_cur.type == _TokType.colon) {
          _advance();
          final endTok = _advance();
          if (endTok.type != _TokType.ident) throw const _FormulaException('#ERROR!');
          // A bare range outside a function has no meaning — surface clearly.
          throw const _FormulaException('#ERROR! (range needs a function like SUM)');
        }
        return engine.valueOf(name);
      }
      if (name == 'TRUE') return true;
      if (name == 'FALSE') return false;
      throw const _FormulaException('#NAME?');
    }
    throw const _FormulaException('#ERROR!');
  }

  dynamic _parseFunctionCall(String name) {
    _advance(); // consume '('
    final args = <dynamic>[];
    final flatNumericArgs = <num>[];

    if (_cur.type != _TokType.rparen) {
      while (true) {
        // Range argument: IDENT ':' IDENT
        if (_cur.type == _TokType.ident &&
            RegExp(r'^[A-Za-z]+\d+$').hasMatch(_cur.text) &&
            tokens[pos + 1].type == _TokType.colon) {
          final startCell = _advance().text.toUpperCase();
          _advance(); // colon
          final endCell = _advance().text.toUpperCase();
          final values = engine.rangeValues(startCell, endCell);
          args.add(values);
          for (final v in values) {
            if (v is num) flatNumericArgs.add(v);
          }
        } else {
          final v = parseExpression();
          args.add(v);
          if (v is num) flatNumericArgs.add(v);
        }
        if (_cur.type == _TokType.comma) {
          _advance();
          continue;
        }
        break;
      }
    }
    if (_cur.type != _TokType.rparen) throw const _FormulaException('#ERROR!');
    _advance();

    switch (name) {
      case 'SUM':
        return flatNumericArgs.fold<num>(0, (a, b) => a + b);
      case 'AVERAGE':
        if (flatNumericArgs.isEmpty) throw const _FormulaException('#DIV/0!');
        return flatNumericArgs.fold<num>(0, (a, b) => a + b) / flatNumericArgs.length;
      case 'MIN':
        if (flatNumericArgs.isEmpty) return 0;
        return flatNumericArgs.reduce((a, b) => a < b ? a : b);
      case 'MAX':
        if (flatNumericArgs.isEmpty) return 0;
        return flatNumericArgs.reduce((a, b) => a > b ? a : b);
      case 'COUNT':
        return flatNumericArgs.length;
      case 'IF':
        if (args.length < 2) throw const _FormulaException('#ERROR!');
        final cond = _bool(args[0]);
        if (cond) return args[1];
        return args.length > 2 ? args[2] : false;
      case 'AND':
        return args.every(_bool);
      case 'OR':
        return args.any(_bool);
      case 'NOT':
        if (args.isEmpty) throw const _FormulaException('#ERROR!');
        return !_bool(args[0]);
      default:
        throw const _FormulaException('#NAME?');
    }
  }

  num _num(dynamic v) {
    if (v is num) return v;
    if (v is bool) return v ? 1 : 0;
    final parsed = num.tryParse(v.toString());
    if (parsed == null) throw const _FormulaException('#VALUE!');
    return parsed;
  }

  bool _bool(dynamic v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    return v.toString().isNotEmpty;
  }

  num _pow(num base, num exp) => math.pow(base, exp);

  dynamic _compare(dynamic left, dynamic right, String op) {
    int cmp;
    if (left is num && right is num) {
      cmp = left.compareTo(right);
    } else {
      cmp = left.toString().compareTo(right.toString());
    }
    switch (op) {
      case '=':
        return cmp == 0;
      case '<>':
        return cmp != 0;
      case '<':
        return cmp < 0;
      case '>':
        return cmp > 0;
      case '<=':
        return cmp <= 0;
      case '>=':
        return cmp >= 0;
    }
    throw const _FormulaException('#ERROR!');
  }
}
