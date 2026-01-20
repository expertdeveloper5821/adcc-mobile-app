import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';

class AcceptedActionsSection extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onContinue;

  const AcceptedActionsSection({
    super.key,
    required this.onShare,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Share Your Challenge button
        AppButton(
          label: 'Share Your Challenge',
          onPressed: onShare,
          type: AppButtonType.primary,
          backgroundColor: AppColors.deepRed,
          textColor: Colors.white,
          width: double.infinity,
          height: 50,
          borderRadius: 12,
          prefixIcon: Icons.share,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        // Continue button
        AppButton(
          label: 'Continue',
          onPressed: onContinue,
          type: AppButtonType.secondary,
          borderColor: AppColors.dustyRose,
          textColor: AppColors.charcoal,
          backgroundColor: AppColors.dustyRose,
          width: double.infinity,
          height: 50,
          borderRadius: 12,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
