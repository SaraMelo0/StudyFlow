import 'package:flutter/material.dart';

import 'package:study_flow/core/strings/study_flow_strings.dart';
import 'package:study_flow/core/theme/study_flow_colors.dart';

class LoginSocialSection extends StatelessWidget {
  const LoginSocialSection({
    super.key,
    required this.textTheme,
    required this.onSocialAuth,
  });

  final TextTheme textTheme;
  final VoidCallback onSocialAuth;

  static const double _btnSize = 52;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: StudyFlowColors.dividerMuted, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                StudyFlow.loginOuContinueCom.texto,
                style: textTheme.bodySmall?.copyWith(
                  color: StudyFlowColors.dividerMuted,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: Divider(color: StudyFlowColors.dividerMuted, thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(
              onPressed: onSocialAuth,
              child: const Text(
                'G',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 20),
            _SocialButton(
              onPressed: onSocialAuth,
              child: Icon(Icons.apple, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 20),
            _SocialButton(
              onPressed: onSocialAuth,
              child: const Text(
                'f',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: StudyFlowColors.orange,
      borderRadius: BorderRadius.circular(12),
      elevation: 0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: LoginSocialSection._btnSize,
          height: LoginSocialSection._btnSize,
          child: Center(child: child),
        ),
      ),
    );
  }
}
