import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/formula_templates_data.dart';
import '../models/formula_template.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_ad_widget.dart';

/// Guided formula builder — pick a function, fill in blanks, get the
/// finished formula. For beginners who find typing raw formulas scary.
class FormulaBuilderScreen extends StatefulWidget {
  const FormulaBuilderScreen({super.key});

  @override
  State<FormulaBuilderScreen> createState() => _FormulaBuilderScreenState();
}

class _FormulaBuilderScreenState extends State<FormulaBuilderScreen> {
  FormulaTemplate? _selected;
  final List<TextEditingController> _controllers = [];

  void _selectTemplate(FormulaTemplate template) {
    setState(() {
      _selected = template;
      _controllers
        ..forEach((c) => c.dispose())
        ..clear()
        ..addAll(List.generate(template.params.length, (_) => TextEditingController()));
    });
  }

  String get _builtFormula {
    if (_selected == null) return '';
    return _selected!.build(_controllers.map((c) => c.text).toList());
  }

  void _copyFormula() {
    Clipboard.setData(ClipboardData(text: _builtFormula));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Formula copy ho gaya! 📋')),
    );
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formula Builder'),
        leading: _selected != null
            ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => setState(() => _selected = null))
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _selected == null ? _buildFunctionList() : _buildForm(_selected!),
            ),
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: formulaTemplates.length,
      itemBuilder: (context, index) {
        final t = formulaTemplates[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(t.functionName, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
            subtitle: Text(t.description),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _selectTemplate(t),
          ),
        );
      },
    );
  }

  Widget _buildForm(FormulaTemplate template) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(template.functionName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
          const SizedBox(height: 4),
          Text(template.description, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          for (var i = 0; i < template.params.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                controller: _controllers[i],
                decoration: InputDecoration(
                  labelText: template.params[i].label,
                  hintText: template.params[i].hint,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          const SizedBox(height: 8),
          const Text('Aapka Formula:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.excelGreen.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.excelGreen.withOpacity(0.3)),
            ),
            child: Text(_builtFormula, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _copyFormula,
              icon: const Icon(Icons.copy),
              label: const Text('Formula Copy Karein'),
            ),
          ),
        ],
      ),
    );
  }
}
