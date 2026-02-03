import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/back_button_widget.dart';

class BannerWithSearch extends StatefulWidget {
  final String imagePath;
  final String title;
  final String? subtitle;
  final bool wantSearchBar;
  final String? searchValue;
  final ValueChanged<String>? onChangeHandler;
  final String? placeholder;
  final double height;

  const BannerWithSearch({
    super.key,
    required this.imagePath,
    required this.title,
    this.subtitle,
    this.wantSearchBar = false,
    this.searchValue,
    this.onChangeHandler,
    this.placeholder,
    this.height = 350,
  });

  @override
  State<BannerWithSearch> createState() => _BannerWithSearchState();
}

class _BannerWithSearchState extends State<BannerWithSearch> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchValue ?? '');
  }

  @override
  void didUpdateWidget(covariant BannerWithSearch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.searchValue != oldWidget.searchValue) {
      _searchController.text = widget.searchValue ?? '';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: Stack(
          children: [
            /// Background Image
            Image.asset(
              widget.imagePath,
              height: widget.height,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: AppColors.softCream,
                );
              },
            ),

            /// Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),

            /// Back Button
            if (widget.showBackButton)
              Positioned(
                top: 16,
                left: 16,
                child: AppBackButton(
                  backgroundColor: AppColors.softCream,
                  iconColor: AppColors.deepRed,
                  onBack: widget.onBack ?? () => Navigator.pop(context),
                ),
              ),

                // Subtitle (if provided)
                if (widget.subtitle != null && widget.subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    widget.subtitle!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],

                // Search Bar (if enabled)
                if (widget.wantSearchBar) ...[
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.23),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  /// Subtitle
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      widget.subtitle!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],

                  /// Search Bar
                  if (widget.wantSearchBar) ...[
                    const SizedBox(height: 14),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: widget.onChangeHandler,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: widget.placeholder ?? 'Search...',
                          hintStyle: const TextStyle(
                            color: Colors.white70,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white70,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
