import 'dart:async';
import 'package:adcc/core/services/location_storage_service.dart';
import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/l10n/app_localizations.dart';
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

class _ProfileHeaderState extends State<ProfileHeader>
    with WidgetsBindingObserver {
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

    _refreshTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      checkCount++;

      if (checkCount >= 5) {
        timer.cancel();
        return;
      }

      await _loadLocation();

      if (_city.isNotEmpty) {
        timer.cancel();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
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
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage(widget.profileImagePath),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1, // 100% line height
                    letterSpacing: 0,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/location.png',
                      height: 14,
                      width: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _city.isEmpty ? l10n.fetchingLocation : _city,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1, // 100% line height
                        letterSpacing: 0,
                        color: Color(0xFF767779),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: widget.onNotificationTap,
            child: Image.asset(
              'assets/icons/notification.gif',
              height: 60,
              width: 60,
            ),
          ),
        ],
      ),
    );
  }
}
