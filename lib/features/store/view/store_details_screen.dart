import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'sections/store_header_section.dart';
import 'sections/store_product_info_section.dart';
import 'sections/store_seller_section.dart';
import 'sections/store_description_section.dart';
import 'sections/store_product_details_section.dart';
import 'sections/store_action_buttons_section.dart';

class StoreDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> productData;

  const StoreDetailsScreen({
    super.key,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Header with back button and product image
            StoreHeaderSection(
            
              // imagePath: productData['image'] as String? ?? 'assets/images/store_header_banner.png',
              // For testing purposes, replace with the actual image path
              imagePath: 'assets/images/store_header_banner.png',  
              onBack: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),

            const SizedBox(height: 16),

            // Product Info Section (title, location, time, price)
            StoreProductInfoSection(
              title: productData['title'] as String? ?? 'Product Title',
              location: productData['location'] as String? ?? 'Abu Dhabi City',
              timePosted: productData['timePosted'] as String? ?? '2 days ago',
              currentPrice: productData['currentPrice'] as String? ?? 'AED 12,999',
              originalPrice: productData['originalPrice'] as String?,
              isNegotiable: productData['isNegotiable'] as bool? ?? false,
            ),

            const SizedBox(height: 16),

            // Seller Information Section
            StoreSellerSection(
              sellerName: productData['sellerName'] as String? ?? 'Ahmed Al Mansouri',
              sellerImage: productData['sellerImage'] as String? ?? 'assets/images/profile.png',
              sellerLocation: productData['location'] as String? ?? 'Abu Dhabi City',
              listingCount: productData['listingCount'] as int? ?? 3,
              rating: productData['rating'] as double? ?? 4.9,
            ),

            const SizedBox(height: 24),

            // Description Section
            StoreDescriptionSection(
              description: productData['description'] as String? ??
                  'Professional carbon fiber road bike, barely used. Shimano Ultegra groupset, excellent condition. Only 500km ridden. Selling because upgrading to a new model.',
            ),

            const SizedBox(height: 24),

            // Product Details Section (tags/pills)
            StoreProductDetailsSection(
              details: productData['productDetails'] as List<String>? ??
                  [
                    'Size: 54cm',
                    'Disc Brakes',
                    'Carbon Fiber Frame',
                    'Less Than 6 Months Old',
                    'Shimano Ultegra R8000',
                  ],
            ),

            const SizedBox(height: 24),

            // Action Buttons Section
            StoreActionButtonsSection(
              onWhatsApp: () {
                // Handle WhatsApp action
                debugPrint('WhatsApp Seller tapped');
              },
              onCall: () {
                // Handle Call action
                debugPrint('Call Seller tapped');
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

