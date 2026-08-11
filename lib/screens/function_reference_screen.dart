import 'package:flutter/material.dart';
import '../data/functions_data.dart';
import '../models/excel_function.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_ad_widget.dart';

/// Free, searchable A-Z dictionary of real Excel functions — a quick
/// reference tool, separate from the guided Lessons/Levels content.
class FunctionReferenceScreen extends StatefulWidget {
  const FunctionReferenceScreen({super.key});

  @override
  State<FunctionReferenceScreen> createState() => _FunctionReferenceScreenState();
}

class _FunctionReferenceScreenState extends State<FunctionReferenceScreen> {
  String _query = '';

  List<ExcelFunction> get _filtered {
    if (_query.isEmpty) return excelFunctions;
    final q = _query.toLowerCase();
    return excelFunctions
        .where((f) => f.name.toLowerCase().contains(q) || f.description.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered;
    return Scaffold(
      appBar: AppBar(title: const Text('Function Reference')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Function search karein — jaise VLOOKUP',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  isDense: true,
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            Expanded(
              child: results.isEmpty
                  ? const Center(child: Text('Koi function nahi mila'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final fn = results[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ExpansionTile(
                            title: Text(fn.name, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                            subtitle: Text(fn.category, style: const TextStyle(fontSize: 12)),
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppTheme.excelGreen.withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(fn.syntax, style: const TextStyle(fontFamily: 'monospace')),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(fn.description),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }
}
