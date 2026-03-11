import 'package:flutter/material.dart';

class PromoData {
  final String image;
  final String title;
  final String subtitle;
  final String highlight;
  final String buttonText;

  PromoData({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.highlight,
    required this.buttonText,
  });
}

class PromoCard extends StatelessWidget {
  final PromoData data;

  const PromoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              data.image,
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: -25,
            right: -25,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 10,
                  color: Color(0xFFF2B705),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),

                const Spacer(),

                Text(
                  data.subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 2),

                Row(
                  children: [

                    Expanded(
                      child: Text(
                        data.highlight,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Container(
                      width: 99,
                      height: 29,
                      padding: const EdgeInsets.fromLTRB(2, 6, 2, 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9EF),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: const Center(
                        child: Text(
                          "Find a ride",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFC12D32),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}