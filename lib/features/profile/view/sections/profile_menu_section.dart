import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: Container(
        width: 358,
        height: 400,
      decoration: BoxDecoration(
  color: const Color(0xFFFFF9EF),
  borderRadius: BorderRadius.circular(17.5168),
  boxShadow: [
    BoxShadow(
      color: const Color(0xFF2E3176).withOpacity(0.10),
      offset: const Offset(0, 4.38),
      blurRadius: 30.65,
      spreadRadius: 0,
    ),
  ],
),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.8945),
          child: Column(
  children: const [
    SizedBox(height: 21.8965),

    _MenuItem(
      imagePath: "assets/icons/events_calender.gif",
      title: "My Events & Calendar",
    ),
    _Divider(),

    _MenuItem(
       imagePath: "assets/icons/point.gif",
      title: "Badges & achievements",
    ),
    _Divider(),

    _MenuItem(
      imagePath: "assets/icons/my_challenges.gif",
      title: "My Challenges",
    ),
    _Divider(),

    _MenuItem(
      imagePath: "assets/icons/point.gif",
      title: "Rewards and points",
    ),
    _Divider(),

    _MenuItem(
      imagePath: "assets/icons/settings.gif",
      title: "Settings & preferences",
      showDivider: false,
    ),
  ],
),
        ),
      ),
    );
  }
}


class _MenuItem extends StatelessWidget {
  final String imagePath;   // 👈 change
  final String title;
  final bool showDivider;

  const _MenuItem({
    required this.imagePath,
    required this.title,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 314.2079,
      height: 52.5505,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                imagePath,
                width: 22,
                height: 22,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.charcoal,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.chevron_right,
            size: 22,
            color: AppColors.charcoal,
          ),
        ],
      ),
    );
  }
}
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(
        thickness: 1,
        color: Colors.black.withOpacity(0.06),
      ),
    );
  }
}