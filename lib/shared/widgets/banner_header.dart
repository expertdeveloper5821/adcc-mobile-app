import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BannerHeadder extends StatelessWidget {
  final String? imagePath;      // Asset image
  final String? base64Image;    // API base64 image
  final String title;
  final String subtitle;
  final VoidCallback? onBackTap;

  const BannerHeadder({
    super.key,
    this.imagePath,
    this.base64Image,
    required this.title,
    required this.subtitle,
    this.onBackTap,
  });

  ImageProvider _buildImage() {
    // ✅ If base64 image available
    if (base64Image != null &&
        base64Image!.isNotEmpty &&
        base64Image!.contains(',')) {
      try {
        final base64String = base64Image!.split(',').last;
        Uint8List bytes = base64Decode(base64String);
        return MemoryImage(bytes);
      } catch (e) {
        return const AssetImage('assets/images/cycling_1.png');
      }
    }

    // ✅ If asset path available
    if (imagePath != null && imagePath!.isNotEmpty) {
      return AssetImage(imagePath!);
    }

    // ✅ Fallback
    return const AssetImage('assets/images/cycling_1.png');
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 210,
        width: double.infinity,
        child: Stack(
          children: [
            /// Background Image
            Positioned.fill(
              child: Image(
                image: _buildImage(),
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

            /// Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.05),
                      Colors.black.withValues(alpha: 0.35),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                  ),
                ),
              ),
            ),

            /// Back Button
            Positioned(
              left: 14,
              top: 14,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onBackTap ?? () => Navigator.pop(context),
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

            /// Bottom Text
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
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