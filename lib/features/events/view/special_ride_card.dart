import 'dart:convert';
import 'dart:typed_data';
import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/event_details/view/event_details_screen.dart';
import 'package:flutter/material.dart';

class SpecialRideCard extends StatelessWidget {
  static const double _cardHeight = 400;

  final String imagePath;
  final String title;
  final String date;
  final String? time;
  final String? distance;
  final String? location;
  final String? venue;
  final String? riders;

  /// UI values
  final String? eventType; // e.g., "Race"
  final String? groupName; // e.g., "Abu Dhabi Road Racers"
  final String? city; // e.g., "Abu Dhabi"
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
    this.city,
    this.eventId,
    this.onShare,
    this.onTap,
    this.onOpen,
    this.width = 350,
  });

  bool get _isNetworkImage =>
      imagePath.startsWith('http://') || imagePath.startsWith('https://');

  bool get _isBase64Image => imagePath.startsWith('data:image/');

  Uint8List _base64Decode(String dataUri) {
    final base64String =
        dataUri.contains(',') ? dataUri.split(',')[1] : dataUri;
    return base64Decode(base64String);
  }

  Widget _buildImage() {
    if (_isBase64Image) {
      try {
        return Image.memory(
          _base64Decode(imagePath),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      } catch (_) {
        return Container(
          color: Colors.grey[200],
          child: const Icon(Icons.error_outline, size: 48, color: Colors.grey),
        );
      }
    }

    if (_isNetworkImage) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey[200],
          child: const Icon(Icons.error_outline, size: 48, color: Colors.grey),
        ),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }

    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => Container(
        color: Colors.grey[200],
        child: const Icon(Icons.error_outline, size: 48, color: Colors.grey),
      ),
    );
  }

  Widget _chip({
    required String text,
    required Color bg,
    required Color fg,
  }) {
    return Container(
      height: 20,
      padding: const EdgeInsets.fromLTRB(9, 3, 9, 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4.969),
      ),
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 9.98,
            fontWeight: FontWeight.w700,
            height: 1,
            color: fg,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final typeText = (eventType ?? 'Race').trim();
    final cityText = (city ?? location ?? 'Abu Dhabi').trim();
final id = eventId ?? "";

    return GestureDetector(
    onTap: onTap ??
    () {
      if (id.isEmpty) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EventDetailsScreen(eventId: id),
        ),
      );
    
          },
      child: SizedBox(
        width: width,
        height: _cardHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              /// Background Image
              Positioned.fill(child: _buildImage()),

              /// Top-left Badge: Race
              Positioned(
                left: 12,
                top: 12,
                child: Container(
                  height: 22,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD92C2C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      typeText.isEmpty ? "Race" : typeText,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              /// Top-right Share Button
              Positioned(
                right: 12,
                top: 12,
                child: InkWell(
                  onTap: onShare,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 34,
                    width: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD92C2C),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.share,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              /// Bottom Info Card (Exact)
              Positioned(
                left: 15,
                right: 15,
                bottom: 14,
                child: SizedBox(
                  height: 128,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9EF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Row 1: Open + Abu Dhabi + Group
                        Row(
                          children: [
                            /// Open chip
                            InkWell(
                              onTap: onOpen,
                              child: _chip(
                                text: "Open",
                                bg: const Color(0xFF3EE606).withValues(alpha: 0.33),
                                fg: const Color(0xFF328700),
                              ),
                            ),

                            const SizedBox(width: 6),

                            /// City chip
                            _chip(
                              text: cityText.isEmpty ? "Abu Dhabi" : cityText,
                              bg: const Color(0xFF3EE606).withValues(alpha: 0.33),
                              fg: const Color(0xFF328700),
                            ),

                            if (groupName != null &&
                                groupName!.trim().isNotEmpty)
                              const SizedBox(width: 6),

                            /// Group chip
                            if (groupName != null &&
                                groupName!.trim().isNotEmpty)
                              Expanded(
                                child: Container(
                                  height: 20,
                                  padding: const EdgeInsets.fromLTRB(9, 3, 9, 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFBFF3A2),
                                    borderRadius: BorderRadius.circular(4.969),
                                  ),
                                  child: Text(
                                    groupName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 9.98,
                                      fontWeight: FontWeight.w700,
                                      height: 1,
                                      color: Color(0xFF328700),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        /// Title
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.8,
                            fontWeight: FontWeight.w800,
                            color: AppColors.deepRed,
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// Row: Date + Time + KM
                        Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined,
                                size: 14, color: Colors.black87),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                date,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.access_time_filled_outlined,
                                size: 14, color: Colors.black87),
                            const SizedBox(width: 6),
                            Text(
                              (time ?? "5:30 AM"),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.merge_type_rounded,
                                size: 14, color: Colors.black87),
                            const SizedBox(width: 6),
                            Text(
                              (distance ?? "42 km"),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// Row: Location + Venue
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: Colors.black87),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                location ?? "Abu Dhabi",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.route,
                                size: 14, color: Colors.black87),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                venue ?? "Yas Marina Circuit",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
