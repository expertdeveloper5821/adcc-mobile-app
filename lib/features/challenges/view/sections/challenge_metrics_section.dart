import 'package:flutter/material.dart';
import '../../../../shared/widgets/metric_card.dart';

class ChallengeMetricsSection extends StatelessWidget {
  final int joined;
  final int daysLeft;
  final int points;

  const ChallengeMetricsSection({
    super.key,
    required this.joined,
    required this.daysLeft,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          MetricCard(
            icon: Icons.people_outline,
            label: 'Joined',
            value: joined.toString(),
          ),
          const SizedBox(width: 12),
          MetricCard(
            icon: Icons.access_time,
            label: 'Days Left',
            value: daysLeft.toString(),
          ),
          const SizedBox(width: 12),
          MetricCard(
            icon: Icons.emoji_events_outlined,
            label: 'Points',
            value: points.toString(),
          ),
        ],
      ),
    );
  }
}

