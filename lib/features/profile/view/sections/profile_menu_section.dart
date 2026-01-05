import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileMenuSection extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems;
  final Function(int index, String label)? onItemTap;

  const ProfileMenuSection({
    super.key,
    required this.menuItems,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.softCream,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E3176).withValues(alpha: 0.1), // 10% opacity
            offset: const Offset(0, 4.38),
            blurRadius: 30.65,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == menuItems.length - 1;

          return _MenuItem(
            icon: item['icon'] as IconData,
            label: item['label'] as String,
            isLast: isLast,
            onTap: () {
              onItemTap?.call(index, item['label'] as String);
            },
          );
        }).toList(),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isLast;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.isLast,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            border: isLast
                ? null
                : Border(
                    bottom: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
          ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.textDark,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

