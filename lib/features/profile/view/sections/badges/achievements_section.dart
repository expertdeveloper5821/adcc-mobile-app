import 'package:flutter/material.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD4AA27),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildAchievementsGrid(),
          ],
        ),
      ),
    );
  }

 Widget _buildHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
         Image.asset(
  "assets/icons/achive.png",   
  height: 22,
  width: 22,
  fit: BoxFit.contain,
),
          SizedBox(width: 8),
          Text(
            "Achievements",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: const [
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

  Widget _buildAchievementsGrid() {
    const double spacing = 12;
    const double rowSpacing = 16;

    return Column(
      children: [
      
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _AchievementItem(
                imagePath: 'assets/icons/beginner.png',
                label: "Beginner Loop\nBadge",
              ),
            ),
            const SizedBox(width: spacing),
            Expanded(
              child: _AchievementItem(
                imagePath: 'assets/icons/night_rider.jpg',
                label: "Night Rider",
              ),
            ),
            const SizedBox(width: spacing),
            Expanded(
              child: _AchievementItem(
                imagePath: 'assets/icons/beginner.png',
                label: "Awareness\nCampaign Rider",
              ),
            ),
            const SizedBox(width: spacing),
            Expanded(
              child: _AchievementItem(
                imagePath: 'assets/icons/desert.jpg',
                label: "Desert\nEndurance Finisher",
              ),
            ),
          ],
        ),
        const SizedBox(height: rowSpacing),

       
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _AchievementItem(
                imagePath: 'assets/icons/century_club.jpg',
                label: "Century Club",
              ),
            ),
            const SizedBox(width: spacing),
            Expanded(
              child: _AchievementItem(
                imagePath: 'assets/icons/streak_master.jpg',
                label: "Streak Master",
              ),
            ),
         
            const SizedBox(width: spacing),
            const Expanded(child: SizedBox.shrink()),
            const SizedBox(width: spacing),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ],
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const _AchievementItem({
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white.withOpacity(0.2),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            height: 1.2,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}