import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_button.dart';

class RouteActionButtonsSection extends StatelessWidget {
  final VoidCallback? onOpenLinkMyRide;
  final VoidCallback? onOpenMaps;

  const RouteActionButtonsSection({
    super.key,
    this.onOpenLinkMyRide,
    this.onOpenMaps,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         AppButton(
  label: l10n.openInLinkMyRide,
  onPressed: onOpenLinkMyRide,
  type: AppButtonType.primary,
  backgroundColor: AppColors.deepRed,
  suffixImage: "assets/icons/units.png",
  suffixImageColor: Colors.white,
),
          const SizedBox(height: 12),
         AppButton(
  label: l10n.openInMaps,
  onPressed: onOpenMaps,
  type: AppButtonType.secondary,
  borderColor: AppColors.deepRed,
  textColor: AppColors.deepRed,
  backgroundColor: Colors.transparent,
  suffixImage: "assets/icons/units.png",
  suffixImageColor: AppColors.deepRed,
),
        ],
      ),
    );
  }
}
