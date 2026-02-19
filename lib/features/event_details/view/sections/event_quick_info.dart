import 'package:flutter/material.dart';
import 'package:adcc/core/theme/app_colors.dart';

class EventQuickInfoSection extends StatelessWidget {
  final String date;
  final String time;
  final String distance;

  final String minAge;
  final String segment;
  final String registration;

  const EventQuickInfoSection({
    super.key,
    required this.date,
    required this.time,
    required this.distance,
    required this.minAge,
    required this.segment,
    required this.registration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Info",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: 10),

          Column(
            children: [
              Row(
                children: [
                  Expanded(child: _PillInfo(title: "Date", value: date)),
                  const SizedBox(width: 10),
                  Expanded(child: _PillInfo(title: "Time", value: time)),
                  const SizedBox(width: 10),
                  Expanded(child: _PillInfo(title: "Distance", value: distance)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _PillInfo(title: "Min Age", value: minAge)),
                  const SizedBox(width: 10),
                  Expanded(child: _PillInfo(title: "Segment", value: segment)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _PillInfo(title: "Registration", value: registration),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// PILL CARD (same as your UI)
/// ------------------------------------------------------------
class _PillInfo extends StatelessWidget {
  final String title;
  final String value;

  const _PillInfo({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        /// ✅ Quick Info ka background WHITE
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightBeige, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.charcoal.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11.7,
              fontWeight: FontWeight.w900,
              color: AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}
