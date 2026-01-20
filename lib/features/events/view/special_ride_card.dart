import 'dart:convert';
import 'dart:typed_data';
import 'package:adcc/features/event_details/view/event_details_screen.dart';
import 'package:flutter/material.dart';

class SpecialRideCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final String distance;
  final String riders;
  final String? eventId;
  final VoidCallback? onShare;
  final VoidCallback? onTap;
  final double width;

  const SpecialRideCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
    required this.distance,
    required this.riders,
    this.eventId,
    this.onShare,
    this.onTap,
    this.width = 350,
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
          height: 320,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 320,
              color: Colors.grey[200],
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
          height: 320,
          color: Colors.grey[200],
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
        height: 320,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 320,
            color: Colors.grey[200],
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
            height: 320,
            color: Colors.grey[200],
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
        height: 320,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 320,
            color: Colors.grey[200],
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
    return GestureDetector(
      onTap: onTap ??
          () {
            if (eventId != null && eventId!.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailsScreen(
                    eventId: eventId!,
                  ),
                ),
              );
            }
          },
      child: SizedBox(
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              /// Background Image
              _buildImage(),

              /// Share Button
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: onShare,
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Image.asset('assets/icons/share.png'),
                  ),
                ),
              ),

              /// Bottom Info Card
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9EF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title + Date
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            date,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      /// Info Row
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/location.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            flex: 2,
                            child: Text(
                              distance,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Image.asset(
                            'assets/icons/bike_icon.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            flex: 1,
                            child: Text(
                              riders,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
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
