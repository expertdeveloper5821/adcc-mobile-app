import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 358,
        height: 334.4447,
        decoration: BoxDecoration(
          color: const Color(0xFFFFEFD7),
          borderRadius: BorderRadius.circular(18.1252),
          border: Border.all(
            color: const Color(0xFFE6D5C3),
            width: 1.2885,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18.1252),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: 358,
                    height: 160,
                    child: Image.asset(
                              'assets/images/cycling_1.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  
                  Container(
                    width: 358,
                    height: 160,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                      ),
                    ),
                  ),

              
                  const Positioned(
                    bottom: 14,
                    left: 16,
                    child: Text(
                      "December Distance Champion",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Joined",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

         
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ride 500km this month to earn the champion badge",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// Progress Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Progress",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "324 / 500 km",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const LinearProgressIndicator(
                        value: 324 / 500,
                        minHeight: 8,
                        backgroundColor: Color(0xFFE0E0E0),
                        valueColor:
                            AlwaysStoppedAnimation(Color(0xffE85C2A)),
                      ),
                    ),

                    const Spacer(),

                    /// Bottom Info Row
                   Row(
  children: [
    
    Row(
      children: const [
        Icon(
          Icons.access_time,
          size: 18,
          color: Color(0xffD32F2F),
        ),
        SizedBox(width: 6),
        Text(
          "12 days left",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xff5C5C5C),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),

    const SizedBox(width: 20),

    Row(
      children: const [
        Icon(
          Icons.group_outlined,
          size: 18,
          color: Color(0xffD32F2F),
        ),
        SizedBox(width: 6),
        Text(
          "234",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xff5C5C5C),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),

    const Spacer(),


    const Icon(
      Icons.chevron_right,
      size: 22,
      color: Color(0xff9E9E9E),
    ),
  ],
),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}