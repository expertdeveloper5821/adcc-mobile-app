import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


class StoreSafetySection extends StatelessWidget {
  const StoreSafetySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: 358,
        height: 81,
        decoration: BoxDecoration(
          color: const Color(0xFFF0DDAF),
          borderRadius: BorderRadius.circular(16.4),
          border: Border.all(
            color: const Color(0xFFE2C984),
            width: 1.1659,
          ),
        ),
        child: Stack(
          children: [

      const Positioned(
  left: 16,
  top: 20,
  child: Image(
    image: AssetImage("assets/icons/safety_shield.png"),
    height: 24,
    width: 24,
  ),
),

            /// Heading
            const Positioned(
              left: 47,
              top: 15,
              child: Text(
                "Safety Tips",
                style: TextStyle(
                  fontFamily: "Outfit",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.charcoal,
                ),
              ),
            ),

            const Positioned(
              left: 47,
              top: 39,
              child: SizedBox(
                width: 276,
                child: Text(
                  "Meet the seller in a safe public place and inspect the item before payment.",
                  style: TextStyle(
                    fontFamily: "Outfit",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xB21A1C20),
                    height: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}