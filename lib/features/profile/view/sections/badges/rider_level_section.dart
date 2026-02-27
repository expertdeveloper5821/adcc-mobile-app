import 'package:flutter/material.dart';
import 'package:adcc/core/theme/app_colors.dart';

class RiderStatsSection extends StatelessWidget {
  final String riderLevel;
  final String totalBadges;
  final String totalPoints;
  final String inProgress;

  const RiderStatsSection({
    super.key,
    required this.riderLevel,
    required this.totalBadges,
    required this.totalPoints,
    required this.inProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            width: 359,
            height: 40,
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 11,
              left: 13,
              right: 13,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.black.withOpacity(0.06),
                width: 1,
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              riderLevel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1,
                color: AppColors.charcoal,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 75,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              children: [
                _StatCard(
                  title: "Total Badges",
                  value: totalBadges,
                ),
                const SizedBox(width: 13),
                _StatCard(
                  title: "Total Points",
                  value: totalPoints,
                ),
                const SizedBox(width: 13),
                _StatCard(
                  title: "In Progress",
                  value: inProgress,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 111,
      height: 75,
      padding: const EdgeInsets.only(
        top: 19,
        right: 27,
        bottom: 10,
        left: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black.withOpacity(0.06),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: 8.8383),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1,
              color: AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}