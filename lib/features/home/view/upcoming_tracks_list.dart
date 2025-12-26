import 'package:adcc/shared/widgets/track_card.dart';
import 'package:flutter/material.dart';

class UpcomingTracksList extends StatelessWidget {
  const UpcomingTracksList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: const [
          TrackCard(
            image: 'assets/images/track.png',
            title: 'Hudayriyat Island Track',
            distance: '8.5 km',
            level: 'Beginner Friendly',
            ridesToday: '3 rides today',
            isOpen: true,
          ),
          TrackCard(
            image: 'assets/images/track.png',
            title: 'Yas Island Track',
            distance: '15 km',
            level: 'Intermediate',
            ridesToday: '2 rides today',
            isOpen: true,
          ),
        ],
      ),
    );
  }
}
