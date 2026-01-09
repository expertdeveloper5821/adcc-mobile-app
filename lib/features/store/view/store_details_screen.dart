import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'sections/store_header_section.dart';
import 'sections/store_product_info_section.dart';
import 'sections/store_seller_section.dart';
import 'sections/store_description_section.dart';
import 'sections/store_product_details_section.dart';
import 'sections/store_action_buttons_section.dart';

class StoreDetailsScreen extends StatefulWidget {
  final String productId;

  const StoreDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _productData;

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  // TODO: Replace with actual API call
  Future<void> _loadProductData() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Sample data - replace with actual API response
    setState(() {
      _productData = {
        'id': widget.productId,
        'image': 'assets/images/store_header_banner.png',
        'title': 'Trek Domane',
        'location': 'Sharjah',
        'timePosted': '2 days ago',
        'currentPrice': 'AED 7,500',
        'originalPrice': 'AED 9,000',
        'isNegotiable': true,
        'sellerName': 'Mahmoud shaalan',
        'sellerImage': 'assets/images/profile.png',
        'listingCount': 3,
        'rating': 4.9,
        'description': 'Professional carbon fiber road bike, barely used. Shimano Ultegra groupset, excellent condition. Only 500km ridden. Selling because upgrading to a new model.',
        'productDetails': [
          'Size: 54cm',
          'Disc Brakes',
          'Carbon Fiber Frame',
          'Less Than 6 Months Old',
          'Shimano Ultegra R8000',
        ],
      };
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.softCream,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_productData == null) {
      return Scaffold(
        backgroundColor: AppColors.softCream,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Failed to load product details'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Header with back button and product image
            StoreHeaderSection(
              imagePath: _productData!['image'] as String,
              onBack: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),

            const SizedBox(height: 16),

            // Product Info Section (title, location, time, price)
            StoreProductInfoSection(
              title: _productData!['title'] as String,
              location: _productData!['location'] as String,
              timePosted: _productData!['timePosted'] as String,
              currentPrice: _productData!['currentPrice'] as String,
              originalPrice: _productData!['originalPrice'] as String?,
              isNegotiable: _productData!['isNegotiable'] as bool? ?? false,
            ),

            const SizedBox(height: 16),

            // Seller Information Section
            StoreSellerSection(
              sellerName: _productData!['sellerName'] as String,
              sellerImage: _productData!['sellerImage'] as String,
              sellerLocation: _productData!['location'] as String,
              listingCount: _productData!['listingCount'] as int,
              rating: _productData!['rating'] as double,
            ),

            const SizedBox(height: 24),

            // Description Section
            StoreDescriptionSection(
              description: _productData!['description'] as String,
            ),

            const SizedBox(height: 24),

            // Product Details Section (tags/pills)
            StoreProductDetailsSection(
              details: _productData!['productDetails'] as List<String>,
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

