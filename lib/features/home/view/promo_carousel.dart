import 'package:flutter/material.dart';
import 'promo_card.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.9);
  int _currentIndex = 0;

  final List<PromoData> _items = [
    PromoData(
      image: 'assets/images/cycling_1.png',
      title: 'New to Abu Dhabi\nCycling Club?',
      subtitle: 'Join Your',
      highlight: 'First Community Ride',
      buttonText: 'Find a ride',
    ),
    PromoData(
      image: 'assets/images/cycling_1.png',
      title: 'Ride Together.\nRide Stronger.',
      subtitle: 'Discover',
      highlight: 'Local Events',
      buttonText: 'Explore',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            itemCount: _items.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return PromoCard(data: _items[index]);
            },
          ),
        ),
      ],
    );
  }
}
