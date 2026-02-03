import 'dart:convert';
import 'dart:typed_data';
import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/event_details/view/event_details_screen.dart';
import 'package:flutter/material.dart';

class SpecialRideCard extends StatelessWidget {
  static const double _imageHeight = 400;
  
  final String imagePath;
  final String title;
  final String date;
  final String? time;
  final String? distance;
  final String? location;
  final String? venue;
  final String? riders;
  final String? eventType; // e.g., "Race", "Open"
  final String? groupName; // e.g., "Abu Dhabi Road Racers"
  final String? eventId;
  final VoidCallback? onShare;
  final VoidCallback? onTap;
  final VoidCallback? onOpen;
  final double width;

  const SpecialRideCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
    this.time,
    this.distance,
    this.location,
    this.venue,
    this.riders,
    this.eventType,
    this.groupName,
    this.eventId,
    this.onShare,
    this.onTap,
    this.onOpen,
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
          return SizedBox(
          height: _imageHeight,
          width: double.infinity,
          child: Image.memory(
            _base64Decode(imagePath),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: _imageHeight,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.grey,
                ),
              );
            },
          ),
        );
      } catch (e) {
        return Container(
          height: _imageHeight,
          color: Colors.grey[200],
          child: const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.grey,
          ),
        );
      }
    } else if (_isNetworkImage) {
      return SizedBox(
        height: _imageHeight,
        width: double.infinity,
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: _imageHeight,
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
              height: _imageHeight,
              color: Colors.grey[200],
              child: const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.grey,
              ),
            );
          },
        ),
      );
    } else {
      return SizedBox(
        height: _imageHeight,
        width: double.infinity,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: _imageHeight,
              color: Colors.grey[200],
              child: const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.grey,
              ),
            );
          },
        ),
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
          child: SizedBox(
            height: _imageHeight, // Container height matches image height
            child: Stack(
              children: [
              /// Background Image
              _buildImage(),

              /// Top Row: Event Type Badge (Left) and Share Button (Right)
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Event Type Badge (Left)
                    if (eventType != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.deepRed,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          eventType!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    /// Share Button (Right)
                    GestureDetector(
                      onTap: onShare,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: AppColors.deepRed,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Light Green Badge Buttons
                      if (onOpen != null || groupName != null)
                        Row(
                          children: [
                            if (onOpen != null)
                              InkWell(
                                onTap: onOpen,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.electric_lime.withValues(alpha: 0.54),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Open',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            if (onOpen != null && groupName != null)
                              const SizedBox(width: 8),
                            if (groupName != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.paleGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  groupName!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                          ],
                        ),
                      if (onOpen != null || groupName != null)
                        const SizedBox(height: 10),

                      /// Event Title
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),

                      /// First Info Row: Date, Time, Distance
                      /// TODO: Make dynamic - currently showing static values for design preview
                      Row(
                        children: [
                          // Date - will be dynamic: date.isNotEmpty ? date : 'TBD'
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 16,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              date.isNotEmpty ? date : '18 July 2026',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Time - will be dynamic: time ?? '5:30 AM'
                          Icon(
                            Icons.access_time_filled_outlined,
                            size: 16,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              time ?? '5:30 AM',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Distance - will be dynamic: distance ?? '42 km'
                          Icon(
                            Icons.merge_type_rounded,
                            size: 16,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              distance ?? '42 km',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      /// Second Info Row: Location, Venue
                      /// TODO: Make dynamic - currently showing static values for design preview
                      Row(
                        children: [
                          // Location - will be dynamic: location ?? 'Abu Dhabi'
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              location ?? 'Abu Dhabi',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Venue - will be dynamic: venue ?? 'Yas Marina Circuit'
                          Icon(
                            Icons.route,
                            size: 16,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              venue ?? 'Yas Marina Circuit',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
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
      ),
    );
  }
}
