import 'package:flutter/material.dart';
import 'ride_card.dart';

class HorizontalRideList extends StatelessWidget {
  const HorizontalRideList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 392,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [

          RideCard(
            image: 'assets/images/family_ride.png',
            title: 'Abu Dhabi Road Racers',
            members: '2800 Members',
            buttonText: 'Explore Community',
            onTap: () {},
          ),

          RideCard(
            image: 'assets/images/family_ride.png',
            title: 'Hudayriyat Riders',
            members: '3800 Members',
            buttonText: 'View Details',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}