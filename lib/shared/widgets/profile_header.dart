import 'dart:async';
import 'package:adcc/core/services/location_storage_service.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatefulWidget {
  final String name;
  final String profileImagePath;
  final VoidCallback? onNotificationTap;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.profileImagePath,
    this.onNotificationTap,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}
class _ProfileHeaderState extends State<ProfileHeader> with WidgetsBindingObserver {
  String _city = '';
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadLocation();
    _startPeriodicRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startPeriodicRefresh() {
    int checkCount = 0;
    const maxChecks = 5; // Check 5 times over 10 seconds
    const checkInterval = Duration(seconds: 2);

    _refreshTimer = Timer.periodic(checkInterval, (timer) async {
      checkCount++;
      if (checkCount >= maxChecks) {
        timer.cancel();
        return;
      }
      // Refresh location to catch any updates after permission is granted
      await _loadLocation();
      // Stop early if we got a location
      if (_city.isNotEmpty) {
        timer.cancel();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _loadLocation();
    }
  }

  Future<void> _loadLocation() async {
    final location = await LocationStorageService.getLocation();

    if (location != null && mounted) {
      final newCity = location['city'] ?? '';
      if (newCity != _city) {
        setState(() {
          _city = newCity;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage(widget.profileImagePath),
          ),

          const SizedBox(width: 12),

          // Name & Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/location.png',
                      height: 14,
                      width: 14,
                      color: Colors.grey, // optional tint
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _city.isEmpty ? 'Fetching location...' : _city,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Notification Button
          GestureDetector(
            onTap: widget.onNotificationTap,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
              child:  Center(
                child: Image.asset(
                  'assets/images/notification.png',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
