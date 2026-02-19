import 'package:adcc/features/routes/view/city_tracks_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/section_header.dart';

class ExploreByCitySection extends StatelessWidget {
  const ExploreByCitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final cities = [
      {
        'name': 'Abu Dhabi',
        'count': '24',
        'image': 'assets/svg/abu_dhabi_city_icon.svg',
      },
      {
        'name': 'Al Ain',
        'count': '12',
        'image': 'assets/svg/AI_ain_city_icon.svg',
      },
      {
        'name': 'Dubai',
        'count': '12',
        'image': 'assets/svg/dubai_city_icon.svg',
      },
      {
        'name': 'Al Dhafra',
        'count': '12',
        'image': 'assets/svg/Al_dharfa_city_icon.svg',
      },
      {
        'name': 'Yas Island',
        'count': '12',
        'image': 'assets/svg/yas_island_city_icon.svg',
      },
      {
        'name': 'Liwa',
        'count': '12',
        'image': 'assets/svg/Liwa_city_icon.svg',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Explore by City',
          onViewAll: () {},
          showViewAll: false,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),
          itemCount: cities.length,
          itemBuilder: (context, index) {
            final city = cities[index];
            return GestureDetector(
             onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => CityTracksPage(
        cityName: city['name'] as String,
      ),
    ),
  );
},

          child: SizedBox(
  width: 111,
  height: 75,
  child: Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.dustyRose,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          city['name'] as String,
          style: const TextStyle(
            fontSize: 15.473,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              city['count'] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),
            SvgPicture.asset(
              city['image'] as String,
              width: 19,
              height: 24.945,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ],
    ),
  ),
),

            );
          },
        ),
      ],
    );
  }
}

