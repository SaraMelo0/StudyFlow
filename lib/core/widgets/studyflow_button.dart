import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/study_flow_colors.dart';

class StudyflowPrimaryCta extends StatelessWidget {
  const StudyflowPrimaryCta({
    super.key,
    required this.label,
    required this.textTheme,
    required this.onPressed,
    this.leading,
  });

  final String label;
  final TextTheme textTheme;
  final VoidCallback onPressed;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: StudyFlowColors.orange.withValues(alpha: 0.28),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: StudyFlowColors.orange,
            foregroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          onPressed: onPressed,
          child: leading == null
              ? Text(label)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    leading!,
                    const SizedBox(width: 10),
                    Text(label),
                  ],
                ),
        ),
      ),
    );
  }
}
