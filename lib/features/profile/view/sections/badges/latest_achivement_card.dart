import 'package:flutter/material.dart';

class LatestAchievementCard extends StatelessWidget {
  const LatestAchievementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358,
      height: 218,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 358,
            height: 218,
            decoration: BoxDecoration(
              color: const Color(0xFFF0DDAF),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Positioned(
            top: 24,
            left: 16,
            child: Container(
              width: 47,
              height: 47,
              decoration: const BoxDecoration(
                color: Color(0xFFE6D3A3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/trophy.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 78,
            left: 14,
            child: SizedBox(
              width: 111,
              height: 46,
              child: Text(
                "Latest\nAchievement",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: 0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 164,
            left: 14,
            child: SizedBox(
              width: 166,
              height: 32,
              child: Text(
                "Century Rider\nUnlocked on Dec 20, 2025",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xCC000000),
                ),
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/cycling_1.png',
                width: 141,
                height: 211,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}