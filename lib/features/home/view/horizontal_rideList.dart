import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'ride_card.dart';

class HorizontalRideList extends StatelessWidget {
  const HorizontalRideList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.popularCommunities,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1, // 100% line height
                letterSpacing: 0,
                color: AppColors.textDark,
              ),
            )),
        const SizedBox(height: 22),
        SizedBox(
          height: 392,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            children: [
              RideCard(
                image: 'assets/images/family_ride.png',
                title: 'Abu Dhabi\nRoad Racers',
                members: '2800 Members',
                buttonText: l10n.exploreCommunity,
                onTap: () {},
              ),
              RideCard(
                image: 'assets/images/family_ride.png',
                title: 'Hudayriyat\nRiders',
                members: '3800 Members',
                buttonText: l10n.viewDetails,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
