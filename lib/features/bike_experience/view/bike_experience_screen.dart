import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:adcc/shared/widgets/app_button.dart';
import 'package:adcc/shared/widgets/banner_header.dart';
import 'package:adcc/shared/widgets/adaptive_image.dart';
import 'package:flutter/material.dart';

class BikeExperienceScreen extends StatelessWidget {
  const BikeExperienceScreen({super.key});

  static const String _phoneNumber = '+971 2 123 4567';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          children: [
            BannerHeadder(
              imagePath: 'assets/images/cycling_1.png',
              title: l10n.bikeExperience,
              subtitle: l10n.bikeExperienceSubtitle,
              height: 220,
              onBackTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
            _buildProfessionalSupportBanner(),
            const SizedBox(height: 20),
            _buildServiceCategoriesGrid(),
            const SizedBox(height: 24),
            _buildSectionTitle('Available Services'),
            const SizedBox(height: 12),
            _buildAvailableServicesSection(),
            const SizedBox(height: 24),
            _buildSectionTitle('Service Packages'),
            const SizedBox(height: 12),
            _buildServicePackagesSection(context),
            const SizedBox(height: 24),
            _buildNeedAssistanceSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildProfessionalSupportBanner() {
    const double radius = 16;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightPeach,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.goldenOchre,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Image.asset(
                        'assets/icons/settingIcon.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.settings_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Professional Support,',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            'Always Available',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Text(
                  "ADCC's certified technicians provide expert bike maintenance, repairs, and adjustments. Whether you need routine service or emergency assistance, we're here to keep you riding.",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textDark.withValues(alpha: 0.9),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCategoriesGrid() {
    const String cycleIconPath = 'assets/icons/cycleIcon.png';
    final categories = [
      {'title': 'Bike Setup', 'subtitle': 'Fitting & guides'},
      {'title': 'Maintenance', 'subtitle': 'Service & repair'},
      {'title': 'Emergency', 'subtitle': '24/7 support'},
      {'title': 'Shop', 'subtitle': 'Gear & parts'},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.15,
      children: categories.map((c) {
        return _buildCategoryCard(
          title: c['title'] as String,
          subtitle: c['subtitle'] as String,
          imagePath: cycleIconPath,
        );
      }).toList(),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardLightBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              Icons.directions_bike_rounded,
              size: 28,
              color: AppColors.goldenOchre,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textDark.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableServicesSection() {
    final services = [
      {
        'title': 'Before Your Ride',
        'description':
            'Pre-ride safety checks, tire pressure adjustment, and quick tune-ups to ensure you start safe.',
        'image': 'assets/images/cycling_1.png',
      },
      {
        'title': 'During Your Ride',
        'description':
            'On-the-go support and tips to keep your ride smooth and safe.',
        'image': 'assets/images/cycling_1.png',
      },
      {
        'title': 'After Your Ride',
        'description':
            'Post-ride checks and maintenance to keep your bike in top condition.',
        'image': 'assets/images/cycling_1.png',
      },
    ];

    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final s = services[index];
          return SizedBox(
            width: 280,
            child: _buildServiceCard(
              title: s['title']!,
              description: s['description']!,
              imagePath: s['image']!,
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: AdaptiveImage(
              imagePath: imagePath,
              fit: BoxFit.cover,
              placeholderColor: AppColors.softCream,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.75),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Material(
              color: AppColors.deepRed,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  // TODO: Share this service
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: _ShareBadge(),
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textDark.withValues(alpha: 0.8),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicePackagesSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: _buildPackageCard(
            title: l10n.basicTuneUp,
            duration: '1-2 hours',
            price: 'AED 150',
            imagePath: 'assets/images/cycling_1.png',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildPackageCard(
            title: l10n.fullService,
            duration: '2-3 hours',
            price: 'AED 7500',
            imagePath: 'assets/images/cycling_1.png',
          ),
        ),
      ],
    );
  }

  Widget _buildPackageCard({
    required String title,
    required String duration,
    required String price,
    required String imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
        // color: AppColors.cardLightBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AdaptiveImage(
              imagePath: imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholderColor: AppColors.softCream,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textDark.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepRed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeedAssistanceSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.goldenOchre.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.directions_bike_rounded,
            size: 40,
            color: AppColors.deepRed.withValues(alpha: 0.9),
          ),
          const SizedBox(height: 12),
          const Text(
            'Need Assistance?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Our expert technicians are available to help with any bike-related questions or issues.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textDark.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: '${l10n.call}: $_phoneNumber',
            onPressed: () => _onCallTapped(context),
            backgroundColor: AppColors.deepRed,
            textColor: Colors.white,
            height: 48,
            borderRadius: 12,
          ),
          const SizedBox(height: 10),
          AppButton(
            label: l10n.bookAppointment,
            onPressed: () => _onBookAppointmentTapped(context),
            type: AppButtonType.secondary,
            // backgroundColor: AppColors.cardLightBackground,
            textColor: AppColors.deepRed,
            borderColor: AppColors.deepRed,
            height: 48,
            borderRadius: 12,
          ),
        ],
      ),
    );
  }

  void _onCallTapped(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${l10n.calling} $_phoneNumber'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onBookAppointmentTapped(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.bookAppointmentComingSoon),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Same share module as [community_type_details._ShareBadge] — share icon for use on cards.
class _ShareBadge extends StatelessWidget {
  const _ShareBadge();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/share.png',
      height: 20,
      width: 20,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Icon(
        Icons.share_rounded,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
