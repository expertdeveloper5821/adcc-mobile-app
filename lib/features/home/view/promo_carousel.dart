import 'package:adcc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'promo_card.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final PageController _controller = PageController(
    viewportFraction: 0.92,
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      PromoData(
        image: 'assets/images/cycling_1.png',
        title: l10n.promoNewToClub,
        subtitle: l10n.promoJoinYour,
        highlight: l10n.promoFirstCommunityRide,
        buttonText: l10n.findRide,
      ),
      PromoData(
        image: 'assets/images/cycling_1.png',
        title: l10n.promoRideTogether,
        subtitle: l10n.promoJoinYour,
        highlight: l10n.promoFirstCommunityRide,
        buttonText: l10n.findRide,
      ),
      PromoData(
        image: 'assets/images/cycling_1.png',
        title: l10n.promoExploreRoutes,
        subtitle: l10n.promoJoinYour,
        highlight: l10n.promoFirstCommunityRide,
        buttonText: l10n.findRide,
      ),
    ];
    return SizedBox(
      height: 170,
      child: PageView.builder(
        controller: _controller,
        itemCount: items.length,
        padEnds: false,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.5),
            child: PromoCard(data: items[index]),
          );
        },
      ),
    );
  }
}