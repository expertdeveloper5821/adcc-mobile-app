import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/shared/widgets/back_button_widget.dart';

class EventHeaderSection extends StatelessWidget {
  final String imagePath;
  final VoidCallback onBack;

  const EventHeaderSection({
    super.key,
    required this.imagePath,
    required this.onBack,
  });

  bool get _isNetworkImage {
    return imagePath.startsWith('http://') || imagePath.startsWith('https://');
  }

  bool get _isBase64Image {
    return imagePath.startsWith('data:image/');
  }

  Widget _buildImage() {
    if (_isBase64Image) {
      // Handle base64 image
      try {
        return Image.memory(
          _base64Decode(imagePath),
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 300,
              color: AppColors.softCream,
              child: const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.grey,
              ),
            );
          },
        );
      } catch (e) {
        return Container(
          height: 300,
          color: AppColors.softCream,
          child: const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.grey,
          ),
        );
      }
    } else if (_isNetworkImage) {
      return Image.network(
        imagePath,
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 300,
            color: AppColors.softCream,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 300,
            color: AppColors.softCream,
            child: const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.grey,
            ),
          );
        },
      );
    } else {
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 300,
            color: AppColors.softCream,
            child: const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.grey,
            ),
          );
        },
      );
    }
  }

  /// Decode base64 image data URI
  Uint8List _base64Decode(String dataUri) {
    // Remove data URI prefix (e.g., "data:image/png;base64,")
    final base64String =
        dataUri.contains(',') ? dataUri.split(',')[1] : dataUri;
    return base64Decode(base64String);
  }

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
            child: _buildImage(),
          ),
        ],
      ),
    );
  }
}
