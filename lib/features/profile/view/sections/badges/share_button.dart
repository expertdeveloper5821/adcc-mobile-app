import 'package:flutter/material.dart';

class ShareAchievementsButton extends StatelessWidget {
  const ShareAchievementsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        width: 358,
        height: 51,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC12D32),
            elevation: 0,
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/share.png',
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 7.2443),
              const Text(
                "Share My Achievements",
                style: TextStyle(
                  fontSize: 14.5157,
                  fontWeight: FontWeight.w400,
                  height: 21.7735 / 14.5157,
                  letterSpacing: 0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}