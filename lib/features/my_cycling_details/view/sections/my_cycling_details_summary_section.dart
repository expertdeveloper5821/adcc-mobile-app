import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';

class MyCyclingDetailsSummarySection extends StatelessWidget {
  const MyCyclingDetailsSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rider level membership + quick summary
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _MembershipSummaryCard(),
        ),
        const SizedBox(height: 30),

        // Cycling identity section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _CyclingIdentityCard(),
        ),
        const SizedBox(height: 40),

        // Your Rides & Events
        const _RidesAndEventsSection(),
        const SizedBox(height: 20),

        // Completed rides CTA
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _CompletedRidesCta(),
        ),
        const SizedBox(height: 30),

        // Your Communities
        const _CommunitiesSection(),
        const SizedBox(height: 30),

        // Your Listed Gear
        const _ListedGearSection(),
      ],
    );
  }
}

class _MembershipSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16),
      // SizedBox(height: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Rider level membership',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.charcoal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _StatMiniCard(
                label: 'Total Distance',
                value: '1,247 km',
              ),
              const SizedBox(width: 12),
              _StatMiniCard(
                label: 'Ride Streak',
                value: '6 Days',
              ),
              const SizedBox(width: 12),
              _StatMiniCard(
                label: 'Badges Earned',
                value: '12',
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deepRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                // TODO: navigate to full stats
              },
              child: const Text(
                'View Full Stats',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatMiniCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatMiniCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.charcoal.withValues(alpha: 0.23),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.normal,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CyclingIdentityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.buttonGuest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 20,
                height: 20,
                child: SvgPicture.asset(
                  'assets/svg/goal.svg',
                ),
              ),
              SizedBox(width: 8),
              const Text(
                'Your Cycling Identity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.charcoal,
                ),
              ),
              // const Text(
              //   '135 km to next level',
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: AppColors.textSecondary,
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Level Progress',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.charcoal,
                ),
              ),
              const Text(
                '73% to next level',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.charcoal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            minHeight: 12,
            value: 0.73,
            backgroundColor: AppColors.white,
            borderRadius: BorderRadius.circular(37041432),
            color: AppColors.warnYellow,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _IdentityPill(
                label: 'Beginner',
                value: '1',
              ),
              _IdentityPill(
                label: 'Intermediate',
                value: '2',
              ),
              _IdentityPill(
                label: 'Advanced',
                value: '3',
              ),
              _IdentityPill(
                label: 'Ambassador',
                value: '4',
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Keep riding to level up.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}

class _IdentityPill extends StatelessWidget {
  final String label;
  final String value;

  const _IdentityPill({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.dustyRose,
          ),
          height: 40,
          width: 40,
          alignment: Alignment.center,
          child: Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
        ),
      ],
    );
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RidesAndEventsSection extends StatelessWidget {
  const _RidesAndEventsSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final rides = [
      {
        'image': 'assets/images/cycling_1.png',
        'distance': '25 km',
        'countOfRiders': '25k riders',
        'title': 'UAE National Day Ride',
        'meta': '32 km · 1h 25m',
        'tag': 'Progressive',
        'date': 'Dec 2',
      },
      {
        'image': 'assets/images/cycling_1.png',
        'distance': '25 km',
        'countOfRiders': '25k riders',
        'title': 'UAE Amateur Stage Ride',
        'meta': '48 km · 2h 05m',
        'tag': 'Intermediate',
        'date': 'Dec 4',
      },
      {
        'image': 'assets/images/cycling_1.png',
        'distance': '25 km',
        'countOfRiders': '25k riders',
        'title': 'UAE National Day Ride',
        'meta': '28 km · 1h 10m',
        'tag': 'Night Ride',
        'date': 'Dec 6',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Rides & Events',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                    fontSize: 20),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.charcoal,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: AppColors.charcoal,
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: rides
                .map(
                  (ride) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _RideListItem(
                      imagePath: ride['image']!,
                      distance: ride['distance']!,
                      countOfRiders: ride['countOfRiders']!,
                      title: ride['title']!,
                      meta: ride['meta']!,
                      tag: ride['tag']!,
                      date: ride['date']!,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _RideListItem extends StatelessWidget {
  final String imagePath;
  final String distance;
  final String countOfRiders;
  final String title;
  final String meta;
  final String tag;
  final String date;

  const _RideListItem({
    required this.imagePath,
    required this.title,
    required this.meta,
    required this.tag,
    required this.date,
    required this.distance,
    required this.countOfRiders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              imagePath,
              width: 104,
              height: 104,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                      width: 10,
                      child: SvgPicture.asset(
                        'assets/svg/navigation.svg',
                        colorFilter: ColorFilter.mode(
                          AppColors.charcoal,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      distance,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.charcoal,
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.directions_bike,
                      color: AppColors.charcoal,
                      size: 10,
                    ),
                    SizedBox(width: 6),
                    Text(
                      countOfRiders,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.charcoal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          // TODO: navigate to full stats
                        },
                        child: const Text(
                          'Navigate',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.charcoal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletedRidesCta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.goldenOchre,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          Expanded(
            child: Text(
              'Completed Rides: 18',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.offWhite,
              ),
            ),
          ),
          Icon(
            Icons.directions_bike,
            size: 26,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}

class _CommunitiesSection extends StatelessWidget {
  const _CommunitiesSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final communities = [
      'Abu Dhabi Riders',
      'Long Distance Crew',
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.people_outline,
                size: 20,
              ),
              SizedBox(width: 4),
              Text(
                'Your Communities',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.charcoal,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.charcoal,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: AppColors.charcoal,
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 20,
            runSpacing: 8,
            children: communities
                .map(
                  (label) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warmSand,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.charcoal,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ListedGearSection extends StatelessWidget {
  const _ListedGearSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // For now re-use static items; could be wired to store data later
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Listed Gear',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 260,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                SizedBox(width: 4),
                _GearItemCard(),
                SizedBox(width: 24),
                _GearItemCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GearItemCard extends StatelessWidget {
  const _GearItemCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/bike.png',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: AppColors.black.withValues(alpha: 0.25),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: AppColors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Sharjah',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'DRT 830 Road Shoes',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      '1300 AED',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.charcoal,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.circle,
                      size: 4,
                      color: AppColors.charcoal.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '2 days ago',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.charcoal.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Posted by Mark McEvoy',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.charcoal.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
