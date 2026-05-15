import 'package:flutter/material.dart';

import 'package:study_flow/core/theme/study_flow_colors.dart';

class StudyflowLogoHeader extends StatelessWidget {
  const StudyflowLogoHeader({
    super.key,
    this.onBack,
    this.logoHeight = 40,
    this.logoAssetPath = 'assets/logo/logo-studyflow.png',
  });

  final VoidCallback? onBack;
  final double logoHeight;
  final String logoAssetPath;

  static const double _sideSlot = 48;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: _sideSlot,
          height: _sideSlot,
          child: onBack != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: StudyFlowColors.preto,
                  onPressed: onBack,
                  padding: EdgeInsets.zero,
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
          child: Center(
            child: Image.asset(
              logoAssetPath,
              height: logoHeight,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: _sideSlot),
      ],
    );
  }
}
