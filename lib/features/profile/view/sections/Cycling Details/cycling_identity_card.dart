import 'package:flutter/material.dart';

class CyclingIdentityCard extends StatelessWidget {
  const CyclingIdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1),
      child: Container(
        width: 358,
        height: 242,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF0DDAF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TITLE
            Row(
              children:  [
              Image.asset(
  "assets/icons/achive.png", // apni image ka path
  width: 22,
  height: 22,
  fit: BoxFit.contain,
  color: Colors.black87,
),
                SizedBox(width: 8),
                Text(
                  "Your Cycling Identity",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// DESCRIPTION
            const Text(
              "Your Cycling Stats Come From Events And Rides.",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff4A4A4A),
              ),
            ),

            const SizedBox(height: 18),

            /// PROGRESS TEXT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Level Progress",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "73% to next level",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// PROGRESS BAR
       Container(
  width: double.infinity,
  height: 11.21,
  decoration: BoxDecoration(
    color: Colors.white, // inactive color
    borderRadius: BorderRadius.circular(100),
  ),
  child: LayoutBuilder(
    builder: (context, constraints) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: constraints.maxWidth * 0.73, // 73% progress
          decoration: BoxDecoration(
            color: const Color(0xFFD6AC2C), // active color
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );
    },
  ),
),

            const SizedBox(height: 10),

            /// LEVELS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _LevelItem(number: "1", label: "Beginner"),
                _LevelItem(number: "2", label: "Intermediate"),
                _LevelItem(number: "3", label: "Advanced"),
                _LevelItem(number: "4", label: "Ambassador"),
              ],
            ),

            const Spacer(),

            /// FOOTER TEXT
            const Center(
              child: Text(
                "Keep riding to level up.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelItem extends StatelessWidget {
  final String number;
  final String label;

  const _LevelItem({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40.4739,
          height: 40.4739,
          decoration: const BoxDecoration(
            color: Color(0xFFFFEFD7),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 2),

        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
          ),
        )
      ],
    );
  }
}