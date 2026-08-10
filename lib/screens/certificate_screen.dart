import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/app_theme.dart';

/// Lets a (premium) user generate a shareable "Certificate of Completion"
/// with their name on it — good for LinkedIn/resume, and doubles as free
/// word-of-mouth marketing when shared.
class CertificateScreen extends StatefulWidget {
  const CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  final GlobalKey _certificateKey = GlobalKey();
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

  Future<void> _shareCertificate() async {
    if (_confirmedName.isEmpty) return;
    setState(() => _isSharing = true);
    try {
      final boundary =
          _certificateKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/excel_guru_certificate.png');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Maine Excel Guru app se Excel seekh kar yeh certificate paya! 🎉',
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    child: const Text('Certificate Banayein'),
                  ),
                ),
              ] else ...[
                RepaintBoundary(
                  key: _certificateKey,
                  child: _CertificateCard(name: _confirmedName, date: _formattedDate),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSharing ? null : _shareCertificate,
                    icon: _isSharing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.share),
                    label: Text(_isSharing ? 'Taiyaar ho raha hai...' : 'Share Certificate'),
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

class _CertificateCard extends StatelessWidget {
  const _CertificateCard({required this.name, required this.date});
  final String name;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
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
          const Text('Excel Guru', style: TextStyle(color: AppTheme.excelGreen, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
