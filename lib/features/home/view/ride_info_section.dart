import 'package:adcc/shared/widgets/ride_info_card.dart';
import 'package:flutter/material.dart';

class RideInfoSection extends StatelessWidget {
  const RideInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            'Ride in Abu Dhabi',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          // Cards
          const RideInfoCard(
            title: 'Official Cycling Routes',
            subtitle: 'Explore safe routes across Abu Dhabi',
          ),
          SizedBox(height: 12),
          RideInfoCard(
            title: 'Track Safety & Guidelines',
            subtitle: 'Stay safe on every ride',
          ),
        ],
      ),
    );
  }
}
