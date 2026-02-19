import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RouteHeaderSection extends StatelessWidget {
  final String imagePath;
  final VoidCallback onBack;

  const RouteHeaderSection({
    super.key,
    required this.imagePath,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          height: 330, // screenshot ke close
          width: double.infinity,
          child: Stack(
            children: [
              // ✅ Background Image
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.softCream,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image,
                        size: 34,
                        color: Colors.black45,
                      ),
                    );
                  },
                ),
              ),

              // ✅ Optional subtle overlay (makes back button pop)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.03),
                ),
              ),

           Positioned(
  left: -35,
  bottom: -35,
  child: Image.asset(
    'assets/images/frame_1.png', // ✅ your image path
    width: 160,
    height: 160,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      return const SizedBox();
    },
  ),
),


              // ✅ Back Button (white circle)
              Positioned(
                left: 14,
                top: 14,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onBack,
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFFB93A3A),
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
