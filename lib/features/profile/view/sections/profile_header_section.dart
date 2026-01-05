import 'package:flutter/material.dart';
import 'package:adcc/core/theme/app_colors.dart';

class ProfileHeaderSection extends StatelessWidget {
  final String profileImagePath;
  final String name;
  final String location;
  final String skillLevel;
  final Map<String, String> stats;

  const ProfileHeaderSection({
    super.key,
    required this.profileImagePath,
    required this.name,
    required this.location,
    required this.skillLevel,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 60,
      ),
      decoration: const BoxDecoration(
        color: AppColors.deepRed,
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(24),
        //   bottomRight: Radius.circular(24),
        // ),
      ),
      child: Column(
        children: [
          // Title
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // Profile Picture
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(profileImagePath),
            backgroundColor: Colors.white,
          ),

          const SizedBox(height: 16),

          // Name
          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          // Location & Skill
          Text(
            '$location - $skillLevel',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 24),

          // Statistics
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.straighten,
                  value: stats['km'] ?? '0',
                  label: 'KM',
                ),
                _buildStatItem(
                  icon: Icons.directions_bike,
                  value: stats['rides'] ?? '0',
                  label: 'Rides',
                ),
                _buildStatItem(
                  icon: Icons.celebration,
                  value: stats['events'] ?? '0',
                  label: 'Events',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppColors.charcoal,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
