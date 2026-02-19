import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RouteSafetySection extends StatelessWidget {
  final String safetyMessage;

  const RouteSafetySection({
    super.key,
    required this.safetyMessage,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> points = _parseSafetyPoints(safetyMessage);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: 358,
        height: 136,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        decoration: BoxDecoration(
          color: const Color(0xFFC12D32), // ✅ screenshot red
          borderRadius: BorderRadius.circular(11.59),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "Safety Information",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            // Bullet list
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: points.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            "•",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            points[index],
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.25,
                            ),
                          ),
                        ),
                      ],
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
  List<String> _parseSafetyPoints(String text) {
    final lines = text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // remove title if included
    if (lines.isNotEmpty &&
        lines.first.toLowerCase().contains("safety information")) {
      lines.removeAt(0);
    }

    return lines.map((l) {
      return l
          .replaceFirst(RegExp(r'^[•\-\*]\s*'), '')
          .trim();
    }).toList();
  }
}
