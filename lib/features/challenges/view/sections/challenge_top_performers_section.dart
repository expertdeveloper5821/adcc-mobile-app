import 'package:flutter/material.dart';
import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/shared/widgets/section_header.dart';
import 'package:adcc/shared/widgets/app_button.dart';

class ChallengeTopPerformersSection extends StatelessWidget {
  final List<Map<String, dynamic>> performers;
  final VoidCallback onViewAll;
  final VoidCallback? onJoin;
  final VoidCallback? onMarkComplete;

  const ChallengeTopPerformersSection({
    super.key,
    required this.performers,
    required this.onViewAll,
    this.onJoin,
    this.onMarkComplete,
  });

  String _extractValue(String valueString) {
    // Extract numeric value from strings like "497 km" or "487 km"
    final parts = valueString.split(' ');
    return parts.isNotEmpty ? parts[0] : valueString;
  }

  String _extractUnit(String valueString) {
    // Extract unit from strings like "497 km" or "487 km"
    final parts = valueString.split(' ');
    return parts.length > 1 ? parts[1] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Top Performers',
            onViewAll: onViewAll,
            showViewAll: true,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFD4AF37),
                  Color(0xFFCF9F0C),
                  Color(0xFFB8941E),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ...performers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final performer = entry.value;
                  final isLast = index == performers.length - 1;
                  
                  return Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.directions_bike,
                                  color: AppColors.goldenOchre,
                                  size: 24,
                                ),
                              ),
                              Positioned(
                                top: -4,
                                right: -4,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFD4AF37),
                                        Color(0xFFCF9F0C),
                                        Color(0xFFB8941E),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.emoji_events_outlined,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  performer['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rank #${performer['rank']}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _extractValue(performer['value'] as String),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _extractUnit(performer['value'] as String),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (!isLast)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Divider(
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
          if (onJoin != null || onMarkComplete != null) ...[
            const SizedBox(height: 16),
            if (onJoin != null)
              AppButton(
                label: 'Join Challenge',
                onPressed: onJoin!,
                type: AppButtonType.primary,
                backgroundColor: AppColors.deepRed,
                textColor: Colors.white,
                width: double.infinity,
                height: 50,
                borderRadius: 12,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            
              const SizedBox(height: 12),
           
              AppButton(
                label: 'Mark as complete',
                onPressed: onMarkComplete ?? () {},
                type: AppButtonType.secondary,
                // backgroundColor: AppColors.,
                borderColor: AppColors.deepRed,
                textColor: AppColors.deepRed,
                width: double.infinity,
                height: 50,
                borderRadius: 12,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

