import 'package:flutter/material.dart';

class UpcomingEventCard extends StatelessWidget {
  final String title;
  final String date;
  final String distance;
  final String image;

  const UpcomingEventCard({
    super.key,
    required this.title,
    required this.date,
    required this.distance,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      height: 392,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0DDAF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              height: 254,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 10),

          /// TITLE
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

        
          Row(
            children: [

              const Icon(
                Icons.calendar_today,
                size: 14,
                color: Colors.black54,
              ),

              const SizedBox(width: 4),

              Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(width: 12),

              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Colors.black54,
              ),

              const SizedBox(width: 4),

              Text(
                distance,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          const Spacer(),

        
          Container(
            width: 107,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffC73A3A),
              borderRadius: BorderRadius.circular(9.1),
              border: Border.all(
                color: const Color(0xffC73A3A),
                width: 1.2,
              ),
            ),
            child: const Text(
              "View Details",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}