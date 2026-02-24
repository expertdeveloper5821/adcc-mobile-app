import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class EventFacilitiesSection extends StatelessWidget {
  final List<Map<String, dynamic>> facilities;

  const EventFacilitiesSection({
    super.key,
    required this.facilities,
  });

  static const double _cardW = 79.5645;
  static const double _cardH = 74.6722;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
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

            
              childAspectRatio: _cardW / _cardH,
            ),
            itemCount: facilities.length,
            itemBuilder: (context, index) {
              final facility = facilities[index];

              return _AmenityCard(
                iconPath: facility['icon'] as String,
                label: facility['label'] as String,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AmenityCard extends StatelessWidget {
  final String iconPath;
  final String label;

  const _AmenityCard({
    required this.iconPath,
    required this.label,
  });

  static const double _w = 79.5645;
  static const double _h = 74.6722;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _w,
      height: _h,
      child: Container(
        padding: const EdgeInsets.only(
          top: 13.2461,
          right: 8.9844,
          bottom: 12.9105,
          left: 8.5801,
        ),
        decoration: BoxDecoration(
        
          color: const Color(0xFFFFEFD7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 16,
              height: 16,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.image,
                  size: 16,
                  color: AppColors.charcoal,
                );
              },
            ),

            const SizedBox(height: 4),

            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11.4727, 
                fontWeight: FontWeight.w400,
                color: AppColors.charcoal,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
