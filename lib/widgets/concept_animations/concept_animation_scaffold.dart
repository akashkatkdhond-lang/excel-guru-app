import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Common chrome around every concept-animation: a title, a fixed-height
/// canvas area for the animation itself, a short caption, and a replay
/// button. Individual animations just implement [ConceptAnimationBody].
class ConceptAnimationScaffold extends StatefulWidget {
  const ConceptAnimationScaffold({
    super.key,
    required this.title,
    required this.caption,
    required this.bodyBuilder,
  });

  final String title;
  final String caption;

  /// Builds the animated visual, given an AnimationController the caller
  /// owns (already wired to a replay button).
  final Widget Function(BuildContext context, AnimationController controller) bodyBuilder;

  @override
  State<ConceptAnimationScaffold> createState() => _ConceptAnimationScaffoldState();
}

class _ConceptAnimationScaffoldState extends State<ConceptAnimationScaffold> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('▶️ ', style: TextStyle(fontSize: 18)),
              Expanded(
                child: Text(widget.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: widget.bodyBuilder(context, _controller),
          ),
          const SizedBox(height: 14),
          Text(widget.caption, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4)),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _controller.forward(from: 0),
              icon: const Icon(Icons.replay_rounded, color: AppTheme.excelGreen),
              label: const Text('Dobara Dekho'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows [scaffold] in a bottom sheet — the standard way lesson sections
/// launch a concept animation.
void showConceptAnimation(BuildContext context, Widget scaffold) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => scaffold,
  );
}
