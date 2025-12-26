import 'package:adcc/features/home/view/ride_card.dart';
import 'package:flutter/material.dart';

class HorizontalRideList extends StatelessWidget {
  const HorizontalRideList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          RideCard(
            image: 'assets/images/family_ride.png',
            title: 'Family Rides',
            subtitle: 'Cycling for families and kids',
            onTap: () {},
          ),
          RideCard(
            image: 'assets/images/family_ride.png',
            title: 'SheRides',
            subtitle: 'Women-only, safe rides',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
