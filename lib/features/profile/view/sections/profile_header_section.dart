import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return SizedBox(
      width: 390,
      height: 412,
      child: Container(
        color: AppColors.deepRed,
        child: Column(
          children: [
            const SizedBox(height: 16),

         /// ---------------- HEADER ----------------
SizedBox(
  height: 60,
  child: Stack(
    alignment: Alignment.center,
    children: [
      /// ---- Center Title ----
      const Center(
        child: Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      /// ---- Back Button (Left) ----
      Positioned(
        left: 16,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    ],
  ),
),
            const SizedBox(height: 16),

            /// ---------------- PROFILE IMAGE ----------------
            Container(
              width: 107.03,
              height: 107.03,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(profileImagePath),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),

            const SizedBox(height: 16),

            /// ---------------- NAME ----------------
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            /// ---------------- LOCATION + SKILL ----------------
            Text(
              '$location - $skillLevel',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 32),

            /// ---------------- STATS ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem(
                    imagePath: 'assets/svg/meter_colored.svg',
                    value: stats['km'] ?? '0',
                    label: 'KM',
                  ),
                  _buildStatItem(
                    imagePath: 'assets/svg/colored_cycle.svg',
                    value: stats['rides'] ?? '0',
                    label: 'Rides',
                  ),
                  _buildStatItem(
                    imagePath: 'assets/svg/events_colored.svg',
                    value: stats['events'] ?? '0',
                    label: 'Events',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String imagePath,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        /// --- Small Circle (40x40) ---
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              imagePath,
              width: 24,
              height: 24,
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