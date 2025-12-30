import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
        InkWell(
          onTap: onViewAll,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'View All',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 6), // spacing between text & icon
              Image.asset(
                "assets/icons/right_arrow.png",
                height: 12,
                width: 12, 
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
