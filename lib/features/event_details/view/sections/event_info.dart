import 'package:adcc/shared/widgets/ride_info_card.dart';
import 'package:flutter/material.dart';

class EventInfo extends StatelessWidget {
  const EventInfo({super.key});

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
            'Who Can Join',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          // Cards
          const RideInfoCard(
            svgPath:"assets/icons/bike_ride.svg",
            title: 'All ADCC members with',
            subtitle: 'intermediate+ cycling experienc',
          ),
         
        ],
      ),
    );
  }
}
