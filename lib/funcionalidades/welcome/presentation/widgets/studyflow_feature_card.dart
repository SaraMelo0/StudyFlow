import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/study_flow_colors.dart';

class StudyflowFeatureCard extends StatelessWidget {
  const StudyflowFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.textTheme,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: StudyFlowColors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: StudyFlowColors.orange,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: StudyFlowColors.orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
