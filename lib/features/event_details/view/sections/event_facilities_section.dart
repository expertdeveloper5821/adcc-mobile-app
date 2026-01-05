import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class EventFacilitiesSection extends StatelessWidget {
  final List<Map<String, dynamic>> facilities;

  const EventFacilitiesSection({
    super.key,
    required this.facilities,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amenities',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: facilities.length,
            itemBuilder: (context, index) {
              final facility = facilities[index];
              return _buildFacilityCard(
                icon: facility['icon'] as IconData,
                label: facility['label'] as String,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityCard({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.dustyRose,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.charcoal,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.charcoal,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
