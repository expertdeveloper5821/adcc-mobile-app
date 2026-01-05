import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/back_button_widget.dart';
import '../../../shared/widgets/search_box.dart';
import '../../../shared/widgets/category_selector.dart';
import '../../../shared/widgets/store_item_card.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Cycles',
    'Apparel',
    'Accessories',
  ];

  // Sample product data - replace with actual data from API
  final List<Map<String, dynamic>> _products = [
    {
      'image': 'assets/images/cycling_1.png',
      'title': 'Trek Domane',
      'postedBy': 'Mahmoud shaalan',
      'price': '7500 AED',
      'timePosted': '2 days ago',
      'location': 'Sharjah',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'title': 'DMT KR0 Road Shoes',
      'postedBy': 'Mark McEvoy',
      'price': '1300 AED',
      'timePosted': '5 days ago',
      'location': 'Khusab',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'title': 'Garmin Edge 1030 Plus',
      'postedBy': 'Khalid Al Nahyan',
      'price': '1800 AED',
      'timePosted': '1 day ago',
      'location': 'Al Ain',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'title': 'Shimano Pedals & Shoes',
      'postedBy': 'Mark McEvoy',
      'price': '850 AED',
      'timePosted': '2 days ago',
      'location': 'Sharjah',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'title': 'Trek Domane',
      'postedBy': 'Mahmoud shaalan',
      'price': '7500 AED',
      'timePosted': '2 days ago',
      'location': 'Sharjah',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'title': 'DMT KR0 Road Shoes',
      'postedBy': 'Mark McEvoy',
      'price': '1300 AED',
      'timePosted': '5 days ago',
      'location': 'Khusab',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'title': 'Garmin Edge 1030 Plus',
      'postedBy': 'Khalid Al Nahyan',
      'price': '1800 AED',
      'timePosted': '1 day ago',
      'location': 'Al Ain',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'title': 'Shimano Pedals & Shoes',
      'postedBy': 'Mark McEvoy',
      'price': '850 AED',
      'timePosted': '2 days ago',
      'location': 'Sharjah',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Header Section with Back Button, Notification, and Image
            _buildHeaderSection(),

            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Title and Sell Button
                  _buildTitleSection(),

                  const SizedBox(height: 16),

                  // Search Box
                  SearchBox(
                    placeholder: 'Search marketplace...',
                    backgroundColor: AppColors.dustyRose,
                    iconColor: AppColors.charcoal,
                    placeholderColor: AppColors.charcoal,
                    enabledBorderColor: AppColors.charcoal.withValues(alpha: 0.1),
                    enabledBorderWidth: 1.5,
                    borderWidth: 1.5,
                    borderRadius: 10,
                    borderColor: AppColors.charcoal.withValues(alpha: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // Category Filters
                  CategorySelector(
                    categories: _categories,
                    selectedIndex: _selectedCategoryIndex,
                    onSelected: (index) {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // Results Count and Filter Icon
                  _buildResultsHeader(),

                  const SizedBox(height: 16),

                  // Product Grid
                  _buildProductGrid(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Back Button and Notification Bell - positioned above the image with spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBackButton(
                backgroundColor: AppColors.paleGreen.withValues(alpha: 0.36),
                iconColor: AppColors.brand_green,
                onBack: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
              ),
              GestureDetector(
                onTap: () {
                  // Handle notification tap
                  debugPrint('Notification tapped');
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.paleGreen.withValues(alpha: 0.36),
                    shape: BoxShape.circle,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withValues(alpha: 0.2),
                    //     blurRadius: 8,
                    //     offset: const Offset(0, 2),
                    //   ),
                    // ],
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: AppColors.deepRed,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Header Image with rounded corners
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/cycling_1.png',
                  height: 340,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 240,
                      color: AppColors.softCream,
                    );
                  },
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Community Marketplace',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        AppButton(
          label: '+ Sell',
          onPressed: () {
            // Handle sell button tap
            debugPrint('Sell button tapped');
          },
          type: AppButtonType.primary,
          backgroundColor: AppColors.deepRed,
          textColor: Colors.white,
          width: 80,
          height: 36,
          borderRadius: 10,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildResultsHeader() {
    final filteredProducts = _getFilteredProducts();
    final resultCount = filteredProducts.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing $resultCount Result${resultCount != 1 ? 's' : ''}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle filter tap
            debugPrint('Filter tapped');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.filter_alt_outlined,
                color: AppColors.textDark,
                size: 20,
              ),
              const SizedBox(width: 6),
              const Text(
                'Filter',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    final filteredProducts = _getFilteredProducts();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return StoreItemCard(
          imagePath: product['image'] as String,
          title: product['title'] as String,
          postedBy: product['postedBy'] as String,
          price: product['price'] as String,
          timePosted: product['timePosted'] as String?,
          location: product['location'] as String?,
          onTap: () {
            // Handle product tap - navigate to product details
            debugPrint('Product tapped: ${product['title']}');
          },
        );
      },
    );
  }

  List<Map<String, dynamic>> _getFilteredProducts() {
    List<Map<String, dynamic>> filtered = List.from(_products);

    // Filter by category
    if (_selectedCategoryIndex > 0) {
      // In a real app, you would filter by actual category
      // For now, we'll just return all products
      // final category = _categories[_selectedCategoryIndex];
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        final title = (product['title'] as String).toLowerCase();
        final postedBy = (product['postedBy'] as String).toLowerCase();
        final query = _searchQuery.toLowerCase();
        return title.contains(query) || postedBy.contains(query);
      }).toList();
    }

    return filtered;
  }
}

