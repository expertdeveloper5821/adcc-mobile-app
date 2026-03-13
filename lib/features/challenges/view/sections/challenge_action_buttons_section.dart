import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_button.dart';

class ChallengeActionButtonsSection extends StatelessWidget {
  final bool isJoined;
  final bool isCompleted;
  final VoidCallback onJoin;
  final VoidCallback onMarkComplete;

  const ChallengeActionButtonsSection({
    super.key,
    required this.isJoined,
    required this.isCompleted,
    required this.onJoin,
    required this.onMarkComplete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (!isJoined)
            AppButton(
              label: l10n.joinChallenge,
              onPressed: onJoin,
              type: AppButtonType.primary,
              backgroundColor: AppColors.deepRed,
              textColor: Colors.white,
              width: double.infinity,
              height: 50,
              borderRadius: 12,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (isJoined && !isCompleted) ...[
            if (!isJoined) const SizedBox(height: 12),
            AppButton(
              label: l10n.markAsComplete,
              onPressed: onMarkComplete,
              type: AppButtonType.secondary,
              borderColor: AppColors.deepRed,
              textColor: AppColors.deepRed,
              width: double.infinity,
              height: 50,
              borderRadius: 12,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

