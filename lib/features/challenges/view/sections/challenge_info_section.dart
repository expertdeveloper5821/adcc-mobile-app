import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ChallengeInfoSection extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onShare;

  const ChallengeInfoSection({
    super.key,
    required this.title,
    required this.description,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE + SHARE
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              /// TITLE
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.deepRed,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// SHARE BUTTON
              InkWell(
                onTap: onShare,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: const Color(0x5C99D3B5),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/icons/share_2.png",
                      width: 18,
                      height: 18,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// DESCRIPTION
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textDark,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}