import 'package:adcc/features/events/view/special_ride_card.dart';
import 'package:adcc/features/events/view/upcoming_rides.dart';
import 'package:adcc/features/events/services/events_service.dart';
import 'package:adcc/features/home/view/upcoming_tracks_list.dart';
import 'package:adcc/modals/grid_item.dart';
import 'package:adcc/shared/widgets/asymmetric_Image_grid.dart';
import 'package:adcc/shared/widgets/category_selector.dart';
import 'package:adcc/shared/widgets/community_event_card.dart';
import 'package:adcc/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EventsTabState createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  int selectedCategoryIndex = 0;
  bool _isLoading = true;
  String? _errorMessage;
  List<Event> _events = [];
  final EventsService _eventsService = EventsService();

  final List<String> categories = [
    'All',
    'Community Rides',
    'Family & Kids',
    'Shop',
  ];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await _eventsService.getEvents();

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (response.success &&
            response.data != null &&
            response.data!.isNotEmpty) {
          _events = response.data!;
          _errorMessage = null;
          debugPrint('Loaded ${_events.length} events successfully');
        } else {
          _errorMessage = response.message ?? 'Failed to load events';
          _events = [];
          debugPrint('Error loading events: $_errorMessage');
          debugPrint('Response success: ${response.success}');
          debugPrint('Response data: ${response.data}');
        }
      });
    }
  }

  String _getImagePath(Event event) {
    // Use API base64 image if available, otherwise fallback to default
    if (event.mainImage != null && event.mainImage!.isNotEmpty) {
      return event.mainImage!;
    }
    return 'assets/images/ride_events.png';
  }

  String _formatParticipants(Event event) {
    return '${event.currentParticipants ?? 0}${event.maxParticipants != null ? '/${event.maxParticipants}' : ''} riders';
  }

  @override
  Widget build(BuildContext context) {
    // Convert API events to the format expected by the UI
    final List<Map<String, String>> rides = _events.map((event) {
      return {
        "image": _getImagePath(event),
        "title": event.title,
        "date": event.formattedDate ?? "TBD",
        "distance": event.address ?? "N/A",
        "riders": _formatParticipants(event),
        "eventId": event.id,
      };
    }).toList();

    final items = [
      GridItem(
        title: 'Hudayriyat',
        image: 'assets/images/ride_events.png',
      ),
      GridItem(
        title: 'Yas',
        image: 'assets/images/ride_events.png',
      ),
      GridItem(
        title: 'Corniche',
        image: 'assets/images/ride_events.png',
      ),
      GridItem(
        title: 'Al Ain Climb',
        image: 'assets/images/ride_events.png',
      ),
    ];

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _errorMessage != null && rides.isEmpty
                    ? Center(
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
                              _errorMessage!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _loadEvents,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 8,
                        ),
                        children: [
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CommunityEventCard(
                              imagePath: 'assets/images/community_ride.png',
                              title: 'Events & Community Rides',
                              onTap: () {
                                debugPrint('Card tapped');
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CategorySelector(
                              categories: categories,
                              selectedIndex: selectedCategoryIndex,
                              onSelected: (index) {
                                setState(() {
                                  selectedCategoryIndex = index;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SectionHeader(
                                  title: 'Special Rides &\nCampaigns',
                                  onViewAll: () {},
                                ),
                              ),
                              const SizedBox(height: 16),
                              rides.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'No events available',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 300,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        itemCount: rides.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 16),
                                        itemBuilder: (context, index) {
                                          final ride = rides[index];
                                          return SpecialRideCard(
                                            imagePath: ride['image']!,
                                            title: ride['title']!,
                                            date: ride['date']!,
                                            distance: ride['distance']!,
                                            riders: ride['riders']!,
                                            eventId: ride['eventId'],
                                            onShare: () {
                                              debugPrint('Share tapped');
                                            },
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SectionHeader(
                                  title: 'Upcoming Rides &\nActivities',
                                  showViewAll: false,
                                  onViewAll: () {},
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: const UpcomingRides(),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SectionHeader(
                                  title: 'Upcoming Tracks',
                                  onViewAll: () {},
                                ),
                              ),
                              const SizedBox(height: 16),
                              const UpcomingTracksList(),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SectionHeader(
                                  title: 'Most Ride Tracks',
                                  onViewAll: () {},
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: AsymmetricImageGrid(
                                  items: items,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
