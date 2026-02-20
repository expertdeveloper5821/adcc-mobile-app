import 'package:adcc/features/route_details/view/sections/route_communities_section.dart';
import 'package:adcc/features/route_details/view/sections/route_events_section.dart';
import 'package:adcc/features/routes/Models/event_model.dart';
import 'package:adcc/features/routes/services/tracks_services.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'sections/route_header_section.dart';
import 'sections/route_title_section.dart';
import 'sections/route_description_section.dart';
import 'sections/route_details_grid_section.dart';
import 'sections/route_facilities_section.dart';
import 'sections/route_safety_section.dart';
import 'sections/route_photos_section.dart';
import 'sections/route_action_buttons_section.dart';

class RouteDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> routeData;

  const RouteDetailsScreen({
    super.key,
    required this.routeData,
  });

  @override
  State<RouteDetailsScreen> createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  final TracksService _tracksService = TracksService();
  List<EventModel> _trackEvents = [];
  bool _isLoadingEvents = false;

  @override
  void initState() {
    super.initState();
    _loadTrackEvents();
  }

  Future<void> _loadTrackEvents() async {
    final trackId = widget.routeData['_id'] ?? widget.routeData['id'];
    if (trackId == null || trackId.toString().isEmpty) return;

    setState(() => _isLoadingEvents = true);

    try {
      final events = await _tracksService.getTrackRelatedEvents(trackId.toString());
      if (mounted) {
        setState(() {
          _trackEvents = events;
          _isLoadingEvents = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingEvents = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeDetails = {
      'Distance': "${widget.routeData['distance'] ?? '10'} km",
      'Elevation': widget.routeData['elevation'] as String? ?? '+12m',
      'Type': widget.routeData['type'] as String? ?? 'Loop Track',
      'Avg Time': widget.routeData['avgtime'] as String? ?? '18-25 min',
      'Pace': widget.routeData['pace'] as String? ?? 'Beginner / Casual',
    };

    final facilities = <Map<String, dynamic>>[
      {"icon": "assets/icons/water.png", "label": "Water"},
      {"icon": "assets/icons/toilets.png", "label": "Toilets"},
      {"icon": "assets/icons/parking.png", "label": "Parking"},
      {"icon": "assets/icons/light.png", "label": "Lights"},
    ];

    final photos = widget.routeData['photos'] as List<String>? ??
        [
          'assets/images/cycling_1.png',
          'assets/images/cycling_1.png',
          'assets/images/cycling_1.png',
          'assets/images/cycling_1.png',
        ];

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            RouteHeaderSection(
              imagePath: widget.routeData['image'] as String? ?? 'assets/images/cycling_1.png',
              onBack: () {
                if (Navigator.of(context).canPop()) Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 16),
            RouteTitleSection(
              title: widget.routeData['title'] as String? ?? 'Hudayriyat Night Ride',
              status: widget.routeData['status'] as String? ?? 'Open',
              onShare: () {},
            ),
            const SizedBox(height: 16),
            RouteDescriptionSection(
              description: widget.routeData['description'] as String? ??
                  'Join us for an evening ride at Yas Marine Circuit.',
            ),
            const SizedBox(height: 24),
            RouteDetailsGridSection(routeDetails: routeDetails),
            const SizedBox(height: 24),
            RouteFacilitiesSection(facilities: facilities),
            const SizedBox(height: 24),
            RouteActionButtonsSection(
              onOpenLinkMyRide: () {},
              onOpenMaps: () {},
            ),
            const SizedBox(height: 24),
            RoutePhotosSection(photoPaths: photos),
            const SizedBox(height: 24),
            _buildEventsSection(),
            const SizedBox(height: 24),
            RouteCommunitiesSection(
              communities: widget.routeData['communities'] as List<Map<String, dynamic>>? ?? [],
            ),
            const SizedBox(height: 24),
            RouteSafetySection(
              safetyMessage: widget.routeData['safetyMessage'] as String? ??
                  "• Ride early morning or late evening in summer\n"
                  "• Carry sufficient water\n"
                  "• Helmets mandatory\n",
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsSection() {
    if (_isLoadingEvents) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Events on this track",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textDark),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) => _buildSkeletonLoader(),
              ),
            ),
          ],
        ),
      );
    }

    if (_trackEvents.isEmpty) return const SizedBox.shrink();
    return RouteEventsSection(events: _trackEvents);
  }
Widget _buildSkeletonLoader() {
  return Container(
    width: 310,
    height: 210,
    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
    child: Stack(
      children: [
        Positioned.fill(child: Container(color: Colors.grey[400])),
        Positioned.fill(child: Container(color: Colors.black.withValues(alpha: 0.1))),
        Positioned(
          top: 12,
          right: 12,
          child: Container(width: 34, height: 34, decoration: const BoxDecoration(color: Colors.white38, shape: BoxShape.circle)),
        ),
        Positioned(
          left: 10,
          right: 10,
          bottom: 10, // Changed from 6 to 10
          child: Container(
            height: 85, // Reduced from 90 to 85
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(10), // Reduced padding
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 50, height: 18, color: Colors.grey[400]), // Reduced height
                  const SizedBox(height: 6), // Reduced spacing
                  Container(width: 180, height: 12, color: Colors.grey[400]), // Reduced width & height
                  const SizedBox(height: 8), // Reduced spacing
                  Row(
                    children: List.generate(3, (i) => Expanded(
                      child: Row(
                        children: [
                          Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)), // Smaller circle
                          const SizedBox(width: 3), // Reduced spacing
                          Expanded(child: Container(height: 8, color: Colors.grey[400])), // Reduced height
                        ],
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}}