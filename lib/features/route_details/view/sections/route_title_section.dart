import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RouteTitleSection extends StatelessWidget {
  final String title;
  final String status;
  final VoidCallback onShare;

  const RouteTitleSection({
    super.key,
    required this.title,
    required this.status,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Open chip
          _StatusChip(text: status),

          const SizedBox(height: 10),

          // Title + share
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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

              InkWell(
                onTap: onShare,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F4E6),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Icon(
                    Icons.share_outlined,
                    size: 18,
                    color: AppColors.charcoal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =======================
// ✅ Status Chip Widget
// =======================
class _StatusChip extends StatelessWidget {
  final String text;

  const _StatusChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 51,
      height: 24,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFBFF3A2), // screenshot bg
          borderRadius: BorderRadius.circular(7.52),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9, 5.64, 7, 5.36),
          child: Center(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1,
                color: Color(0xFF328700), // screenshot green
              ),
            ),
          ),
        ),
      ),
    );
  }
}
