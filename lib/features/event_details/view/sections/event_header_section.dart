import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/back_button_widget.dart';

class EventHeaderSection extends StatelessWidget {
  final String imagePath;
  final VoidCallback onBack;

  const EventHeaderSection({
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
                iconPath: 'assets/icons/leftArrow.png',
              ),
            ),
          ),
          // Background Image with rounded corners
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 300,
                  color: AppColors.softCream,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
