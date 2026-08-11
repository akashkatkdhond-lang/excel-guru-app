import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

/// Lets a (premium) user generate a real, shareable PDF "Certificate of
/// Completion" with their name and a unique Certificate ID on it — good
/// for LinkedIn/resume, and doubles as free word-of-mouth marketing when
/// shared. No backend/verification server involved (see README for the
/// v2 plan if a public verification page is ever added).
class CertificateScreen extends StatefulWidget {
  const CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _confirmedName = '';
  bool _isSharing = false;

  String get _formattedDate {
    final now = DateTime.now();
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  Future<void> _shareCertificate(String certificateId) async {
    setState(() => _isSharing = true);
    try {
      final pdfBytes = await _buildCertificatePdf(
        name: _confirmedName,
        date: _formattedDate,
        certificateId: certificateId,
      );

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/excel_guru_certificate.pdf');
      await file.writeAsBytes(pdfBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Maine Excel Guru app se Excel seekh kar yeh certificate paya! 🎉 '
            'Certificate ID: $certificateId',
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<List<int>> _buildCertificatePdf({
    required String name,
    required String date,
    required String certificateId,
  }) async {
    final doc = pw.Document();
    final green = PdfColor.fromInt(AppTheme.excelGreen.value);
    final greenDark = PdfColor.fromInt(AppTheme.excelGreenDark.value);
    final accent = PdfColor.fromInt(AppTheme.accent.value);

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: accent, width: 6),
            ),
            padding: const pw.EdgeInsets.all(36),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('EXCEL GURU',
                    style: pw.TextStyle(fontSize: 16, color: green, fontWeight: pw.FontWeight.bold, letterSpacing: 3)),
                pw.SizedBox(height: 18),
                pw.Text('CERTIFICATE OF COMPLETION',
                    style: pw.TextStyle(fontSize: 26, color: greenDark, fontWeight: pw.FontWeight.bold, letterSpacing: 2)),
                pw.SizedBox(height: 28),
                pw.Text('Yeh certificate diya jaata hai', style: const pw.TextStyle(fontSize: 13, color: PdfColors.grey700)),
                pw.SizedBox(height: 10),
                pw.Text(name, style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(
                  'ko Microsoft Excel ke saare lessons safaltapoorvak poora karne ke liye',
                  style: const pw.TextStyle(fontSize: 13, color: PdfColors.grey700),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 32),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text('Date: $date', style: const pw.TextStyle(fontSize: 12)),
                    pw.SizedBox(width: 40),
                    pw.Text('Certificate ID: $certificateId', style: const pw.TextStyle(fontSize: 12)),
                  ],
                ),
                pw.SizedBox(height: 6),
                pw.Text(
                  'Yeh certificate Excel Guru app dwara issue kiya gaya hai (koi government/university authority nahi)',
                  style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
                ),
              ],
            ),
          );
        },
      ),
    );
    return doc.save();
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final certificateId = progress.certificateId;

    return Scaffold(
      appBar: AppBar(title: const Text('Completion Certificate')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (_confirmedName.isEmpty) ...[
                const Text(
                  'Certificate par apna naam kaise dikhna chahiye?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Apna naam likhein',
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final name = _nameController.text.trim();
                      if (name.isNotEmpty) setState(() => _confirmedName = name);
                    },
                    child: const Text('Preview Dekhein'),
                  ),
                ),
              ] else ...[
                _CertificatePreview(
                  name: _confirmedName,
                  date: _formattedDate,
                  certificateId: certificateId,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSharing ? null : () => _shareCertificate(certificateId),
                    icon: _isSharing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.picture_as_pdf),
                    label: Text(_isSharing ? 'PDF taiyaar ho raha hai...' : 'PDF Certificate Share Karein'),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _confirmedName = ''),
                  child: const Text('Naam badlein'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CertificatePreview extends StatelessWidget {
  const _CertificatePreview({required this.name, required this.date, required this.certificateId});
  final String name;
  final String date;
  final String certificateId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accent, width: 4),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12)],
      ),
      child: Column(
        children: [
          const Text('🏆', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          const Text(
            'CERTIFICATE OF COMPLETION',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1.2,
              color: AppTheme.excelGreenDark,
            ),
          ),
          const SizedBox(height: 20),
          const Text('Yeh certificate diya jaata hai', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'ko Microsoft Excel ke saare lessons safaltapoorvak\npoora karne ke liye',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Text(date, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Certificate ID: $certificateId',
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text('Excel Guru', style: TextStyle(color: AppTheme.excelGreen, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
