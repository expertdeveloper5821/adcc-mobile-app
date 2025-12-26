import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String location;
  final String profileImagePath;
  final VoidCallback? onNotificationTap;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.location,
    required this.profileImagePath,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage(profileImagePath),
          ),

          const SizedBox(width: 12),

          // Name & Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
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
                      location,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Notification Button
          GestureDetector(
            onTap: onNotificationTap,
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
