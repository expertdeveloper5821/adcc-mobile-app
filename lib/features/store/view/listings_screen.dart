import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/adaptive_image.dart';

class ListingsScreen extends StatelessWidget {
  final String? imagePath;

  const ListingsScreen({Key? key, this.imagePath}) : super(key: key);

  Widget _listingCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.charcoal.withValues(alpha: 0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area with location badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: AdaptiveImage(
                  imagePath: imagePath ?? 'assets/images/cycling_1.png',
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  placeholderColor: AppColors.charcoal.withValues(alpha: 0.06),
                ),
              ),
              Positioned(
                left: 12,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.location_on, size: 12, color: AppColors.textDark),
                      SizedBox(width: 6),
                      Text(
                        'Sharjah',
                        style: TextStyle(fontSize: 12, color: AppColors.textDark),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Trek Domane',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Posted by Mahmoud shaalan • 2 days ago',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  '7500 AED',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.softCream,
        appBar: AppBar(
          backgroundColor: AppColors.softCream,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'My Listings',
            style: TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.deepRed),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.deepRed,
            labelColor: AppColors.deepRed,
            unselectedLabelColor: AppColors.textDark.withOpacity(0.6),
            tabs: const [
              Tab(text: 'Active listings'),
              Tab(text: 'Sold items'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Active listings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ListView.separated(
                itemCount: 1,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _listingCard(context),
              ),
            ),

            // Sold items (placeholder)
            Center(
              child: Text(
                'No sold items yet',
                style: TextStyle(color: AppColors.textDark.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
