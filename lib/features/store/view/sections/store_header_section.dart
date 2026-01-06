import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/back_button_widget.dart';

class StoreHeaderSection extends StatelessWidget {
  final String imagePath;
  final VoidCallback onBack;

  const StoreHeaderSection({
    super.key,
    required this.imagePath,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Back Button - positioned above the image with spacing
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppBackButton(
                onBack: onBack,
                backgroundColor: AppColors.paleGreen,
                iconColor: AppColors.deepRed,
              ),
            ),
          ),
          // Product Image with rounded bottom corners
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 400,
                  color: AppColors.softCream,
                  child: const Icon(Icons.image, size: 50),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

