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

            /// TITLE ROW WITH IMAGE
            Row(
              children: [
                Image.asset(
                  "assets/icons/achive.png",
                  width: 16,
                  height: 16,
                  fit: BoxFit.contain,
                   color: Colors.black87,
                ),
                const SizedBox(width: 6),
                const Text(
                  "Available Points",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            /// POINT VALUE
            const Text(
              "1,250",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            /// PROGRESS TEXT
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

            /// CUSTOM PROGRESS BAR (FIGMA STYLE)
            Container(
              width: double.infinity,
              height: 11.21,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(37041432),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: constraints.maxWidth * 0.6,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6AC2C),
                        borderRadius: BorderRadius.circular(37041432),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}