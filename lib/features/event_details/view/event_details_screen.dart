import 'package:adcc/features/event_details/view/sections/event_info.dart';
import 'package:adcc/features/events/services/events_service.dart';
import 'package:adcc/modals/info_tile.dart';
import 'package:adcc/shared/widgets/app_button.dart';
import 'package:adcc/shared/widgets/info_grid_section.dart';
import 'package:adcc/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'sections/event_header_section.dart';
import 'sections/event_title_section.dart';
import 'sections/event_description_section.dart';
import 'sections/event_facilities_section.dart';
import 'sections/event_action_buttons_section.dart';

class EventDetailsScreen extends StatefulWidget {
  final String eventId;

  const EventDetailsScreen({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final EventsService _eventsService = EventsService();
  bool _isLoading = true;
  String? _errorMessage;
  Event? _event;

  @override
  void initState() {
    super.initState();
    _loadEventDetails();
  }

  Future<void> _loadEventDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await _eventsService.getEventById(widget.eventId);

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (response.success && response.data != null) {
          _event = response.data;
        } else {
          _errorMessage = response.message ?? 'Failed to load event details';
        }
      });
    }
  }

  String _formatDateTime(Event event) {
    if (event.eventDate == null) return 'TBD';
    try {
      final dateTime = DateTime.parse(event.eventDate!);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      final time = event.eventTime ?? '';
      return '${months[dateTime.month - 1]} ${dateTime.day}${time.isNotEmpty ? ' · $time' : ''}';
    } catch (e) {
      return event.eventDate ?? 'TBD';
    }
  }

  String _getImagePath(Event event) {
    if (event.mainImage != null && event.mainImage!.isNotEmpty) {
      return event.mainImage!;
    }
    return 'assets/images/cycling_1.png';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.softCream,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null || _event == null) {
      return Scaffold(
        backgroundColor: AppColors.softCream,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage ?? 'Event not found',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadEventDetails,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final event = _event!;
    final facilities = <Map<String, dynamic>>[
      {'icon': Icons.water_drop, 'label': 'Water'},
      {'icon': Icons.wc, 'label': 'Toilets'},
      {'icon': Icons.local_parking, 'label': 'Parking'},
      {'icon': Icons.lightbulb, 'label': 'Lights'},
    ];

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Header with back button and image
            EventHeaderSection(
              imagePath: _getImagePath(event),
              onBack: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),

            const SizedBox(height: 16),

            // Route Title with Share
            EventTitleSection(
              title: event.title,
              onShare: () {
                // Handle share
                debugPrint('Share event: ${event.id}');
              },
            ),

            const SizedBox(height: 16),

            // Route Description
            EventDescriptionSection(
              description: event.description ??
                  'No description available for this event.',
            ),

            const SizedBox(height: 24),
            InfoGridSection(
              items: [
                InfoTileData(
                  icon: Icons.access_time,
                  label: 'When',
                  value: _formatDateTime(event),
                ),
                InfoTileData(
                  icon: Icons.location_on,
                  label: 'Location',
                  value: event.address ?? 'TBD',
                ),
                InfoTileData(
                  icon: Icons.star,
                  label: 'Status',
                  value: event.status?.toUpperCase() ?? 'UPCOMING',
                ),
                InfoTileData(
                  icon: Icons.group,
                  label: 'Riders',
                  value: event.participantsString,
                ),
              ],
            ),

            if (event.minAge != null || event.maxAge != null) ...[
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InfoGridSection(
                  items: [
                    if (event.minAge != null)
                      InfoTileData(
                        icon: Icons.person,
                        label: 'Min Age',
                        value: '${event.minAge} years',
                      ),
                    if (event.maxAge != null)
                      InfoTileData(
                        icon: Icons.person_outline,
                        label: 'Max Age',
                        value: '${event.maxAge} years',
                      ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'JOIN THIS RIDE',
                      onPressed: () {
                        // Handle join ride
                        debugPrint('Join ride: ${event.id}');
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// ADD RIDER BUTTON
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1F23),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_add_alt_1,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SectionHeader(
                title: 'Route Preview',
                showViewAll: false,
                onViewAll: () {},
              ),
            ),
            Column(
              children: [
                // IMAGE SECTION
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/route_preview.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InfoGridSection(
                  items: const [
                    InfoTileData(
                      label: 'When',
                      value: '10 km loop',
                    ),
                    InfoTileData(
                      label: 'Location',
                      value: '10 km loop',
                    ),
                    InfoTileData(
                      label: 'Rating',
                      value: '10 km loop',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppButton(
                    label: 'Preview Full Route',
                    suffixIcon: Icons.arrow_forward_ios,
                    onPressed: () {
                      // Handle join ride
                    },
                  ),
                ),
              ],
            ),
            // Facilities
            EventFacilitiesSection(facilities: facilities),

            const SizedBox(height: 24),
            EventInfo(),
            const SizedBox(height: 24),

            // Action Buttons Section (scrollable with content)
            EventActionButtonsSection(
              firstButtonTab: () {},
              secondButtonTab: () {},
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
