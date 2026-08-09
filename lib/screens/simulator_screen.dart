import 'package:flutter/material.dart';
import '../services/formula_engine.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_ad_widget.dart';

const _cols = ['A', 'B', 'C', 'D', 'E', 'F'];
const _rowCount = 12;

/// A minimal live spreadsheet grid where users can type real formulas
/// (=SUM(A1:A5), =IF(...), etc.) and see results instantly — the "learn by
/// doing" part of the app. See lib/services/formula_engine.dart for what
/// is supported.
class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  final Map<String, String> _gridData = {};
  late FormulaEngine _engine;
  String _selectedCell = 'A1';
  final TextEditingController _formulaBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _engine = FormulaEngine(_gridData);
    _loadExample();
  }

  void _loadExample() {
    _gridData
      ..clear()
      ..addAll({
        'A1': 'Item',
        'B1': 'Price',
        'A2': 'Pen',
        'B2': '10',
        'A3': 'Notebook',
        'B3': '40',
        'A4': 'Bag',
        'B4': '250',
        'A5': 'Total',
        'B5': '=SUM(B2:B4)',
        'A6': 'Average',
        'B6': '=AVERAGE(B2:B4)',
        'A7': 'Status',
        'B7': '=IF(B5>200,"Costly","Ok")',
      });
    _engine.invalidate();
    _selectCell('B5');
  }

  void _clearAll() {
    setState(() {
      _gridData.clear();
      _engine.invalidate();
      _selectCell('A1');
    });
  }

  void _selectCell(String cellId) {
    setState(() {
      _selectedCell = cellId;
      _formulaBarController.text = _gridData[cellId] ?? '';
    });
  }

  void _commitFormulaBar(String value) {
    setState(() {
      if (value.isEmpty) {
        _gridData.remove(_selectedCell);
      } else {
        _gridData[_selectedCell] = value;
      }
      _engine.invalidate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Simulator'),
        actions: [
          IconButton(
            tooltip: 'Load example',
            icon: const Icon(Icons.auto_fix_high),
            onPressed: () => setState(_loadExample),
          ),
          IconButton(
            tooltip: 'Clear all',
            icon: const Icon(Icons.delete_outline),
            onPressed: _clearAll,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _FormulaBar(
              selectedCell: _selectedCell,
              controller: _formulaBarController,
              onSubmitted: _commitFormulaBar,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: _Grid(
                    gridData: _gridData,
                    engine: _engine,
                    selectedCell: _selectedCell,
                    onCellTap: _selectCell,
                  ),
                ),
              ),
            ),
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }
}

class _FormulaBar extends StatelessWidget {
  const _FormulaBar({
    required this.selectedCell,
    required this.controller,
    required this.onSubmitted,
  });

  final String selectedCell;
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.excelGreen,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(selectedCell, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Yahan formula ya value likhein — jaise =SUM(B2:B4)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    required this.gridData,
    required this.engine,
    required this.selectedCell,
    required this.onCellTap,
  });

  final Map<String, String> gridData;
  final FormulaEngine engine;
  final String selectedCell;
  final ValueChanged<String> onCellTap;

  static const double cellWidth = 90;
  static const double cellHeight = 42;
  static const double headerWidth = 36;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: const FixedColumnWidth(cellWidth),
      columnWidths: const {0: FixedColumnWidth(headerWidth)},
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          children: [
            const SizedBox(height: cellHeight),
            for (final col in _cols)
              SizedBox(
                height: cellHeight,
                child: Center(child: Text(col, style: const TextStyle(fontWeight: FontWeight.bold))),
              ),
          ],
        ),
        for (var row = 1; row <= _rowCount; row++)
          TableRow(
            children: [
              Container(
                height: cellHeight,
                color: Colors.grey.shade200,
                child: Center(child: Text('$row', style: const TextStyle(fontWeight: FontWeight.bold))),
              ),
              for (final col in _cols) _cellWidget('$col$row'),
            ],
          ),
      ],
    );
  }

  Widget _cellWidget(String cellId) {
    final isSelected = cellId == selectedCell;
    final value = engine.valueOf(cellId);
    final displayText = value == null || value == '' ? '' : value.toString();
    final isError = displayText.startsWith('#');

    return InkWell(
      onTap: () => onCellTap(cellId),
      child: Container(
        height: cellHeight,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        color: isSelected ? AppTheme.excelGreen.withOpacity(0.15) : Colors.white,
        child: Text(
          displayText,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isError ? Colors.red : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
