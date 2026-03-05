import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {
  final String image;
  final String title;
  final String members;
  final String buttonText;
  final VoidCallback onTap;

  const RideCard({
    super.key,
    required this.image,
    required this.title,
    required this.members,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      height: 392,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0DDAF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  height: 293,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                /// GRADIENT OVERLAY
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black54,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                /// TITLE
                Positioned(
                  left: 16,
                  bottom: 14,
                  right: 16,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// MEMBERS ROW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/person_sharp.png",
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  members,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          /// BUTTON
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 14),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 143,
                height: 34,
                padding: const EdgeInsets.fromLTRB(11, 8, 9, 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFC12D32),
                  borderRadius: BorderRadius.circular(9.1),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}