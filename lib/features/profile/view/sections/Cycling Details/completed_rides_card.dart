import 'package:flutter/material.dart';

class CompletedRidesCard extends StatelessWidget {
  final int rides;
  final VoidCallback? onTap;

  const CompletedRidesCard({
    super.key,
    required this.rides,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 358,
          height: 58,
          padding: const EdgeInsets.fromLTRB(
            16,
            15,
            25,
            16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFCF9F0C),
            borderRadius: BorderRadius.circular(7.4843),
            border: Border.all(
              width: 1.5424,
              color: const Color(0xFFCF9F0C),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// TEXT
              Text(
                "Completed Rides: $rides",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              /// ICON
              const Icon(
                Icons.directions_bike,
                color: Colors.white,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}