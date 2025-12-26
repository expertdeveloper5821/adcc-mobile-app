import 'package:adcc/features/home/view/promo_carousel.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/profile_header.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ProfileHeader(
            name: 'Ahmed Al Mansouri',
            location: 'Abu Dhabi City',
            profileImagePath: 'assets/images/profile.png',
            onNotificationTap: () {
              debugPrint('Notification tapped');
            },
          ),
          SizedBox(height: 16),
          PromoCarousel(),
          // Rest of Home content
          const Expanded(child: Center(child: Text('Home Content'))),
        ],
      ),
    );
  }
}
