import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RideTile extends StatelessWidget {
  final String title;
  final String distance;
  final String riders;
  final String date;
  final String imagePath;
  final VoidCallback? onNavigate;

  const RideTile({
    super.key,
    required this.title,
    required this.distance,
    required this.riders,
    required this.date,
    required this.imagePath,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      child: Container(
        width: 358,
        height: 124,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [

            /// IMAGE
            Padding(
              padding: const EdgeInsets.all(9),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  imagePath,
                  width: 105,
                  height: 105,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// RIGHT SIDE
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 5, top: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// TITLE
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.charcoal
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// DISTANCE + RIDERS
                   Row(
  children: [

    /// DISTANCE IMAGE
    Image.asset(
      "assets/icons/km_rides.jpg",
      width: 14,
      height: 14,
      fit: BoxFit.contain,
    ),
    const SizedBox(width: 4),

    Text(
      distance,
      style: const TextStyle(fontSize: 12),
    ),

    const SizedBox(width: 16),

    /// RIDERS IMAGE
    Image.asset(
      "assets/icons/rides.jpg",
      width: 14,
      height: 14,
      fit: BoxFit.contain,
    ),
    const SizedBox(width: 4),

    Text(
      riders,
      style: const TextStyle(fontSize: 12),
    ),
  ],
),
                    const Spacer(),

                    /// BUTTON + DATE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
SizedBox(
  width: 137,
  height: 30,
  child: ElevatedButton(
    onPressed: onNavigate,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        const Color(0xFFC12D32),
      ),
      foregroundColor: MaterialStateProperty.all(
        Colors.white,
      ),
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all(
        const EdgeInsets.fromLTRB(
          40,
          4.4287,
          39,
          4.5713,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
    child: const Text(
      "Navigate",
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),

                        /// DATE
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}