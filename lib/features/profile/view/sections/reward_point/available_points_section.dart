import 'package:flutter/material.dart';

class AvailablePointsSection extends StatelessWidget {
  const AvailablePointsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 2),
      child: Container(
        width: 358, 
        height: 140, 
        decoration: BoxDecoration(
          color: const Color(0xFFF0DDAF), 
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Available Points",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "1,250",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Progress to Gold Tier",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "750 pts to go",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: 0.6,
                minHeight: 8,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(
                  Color(0xFFB58B2A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}