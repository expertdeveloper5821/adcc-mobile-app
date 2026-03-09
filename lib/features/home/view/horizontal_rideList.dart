import 'package:flutter/material.dart';
import 'ride_card.dart';

class HorizontalRideList extends StatelessWidget {
  const HorizontalRideList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Popular Community",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 22),

        SizedBox(
          height: 392,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            children: [

              RideCard(
                image: 'assets/images/family_ride.png',
                title: 'Abu Dhabi\nRoad Racers',
                members: '2800 Members',
                buttonText: 'Explore Community',
                onTap: () {},
              ),

              RideCard(
                image: 'assets/images/family_ride.png',
                title: 'Hudayriyat\nRiders',
                members: '3800 Members',
                buttonText: 'View Details',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}