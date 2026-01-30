import 'dart:ui';

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BannerWithSearch extends StatefulWidget {
  final String imagePath;
  final String title;
  final bool wantSearchBar;
  final String? searchValue;
  final ValueChanged<String>? onChangeHandler;
  final String? placeholder;

  const BannerWithSearch({
    super.key,
    required this.imagePath,
    required this.title,
    this.wantSearchBar = false,
    this.searchValue,
    this.onChangeHandler,
    this.placeholder,
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
  void didUpdateWidget(BannerWithSearch oldWidget) {
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
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // Background Image
          Image.asset(
            widget.imagePath,
            height: 240,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 400,
                color: AppColors.softCream,
              );
            },
          ),

          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.2725, 1.0],
                  colors: [
                    Colors.transparent,
                    Color.fromRGBO(0, 0, 0, 0.9),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Positioned(
            left: 24,
            right: 24,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Search Bar (if enabled)
                if (widget.wantSearchBar) ...[
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.21),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          cursorColor: Colors.white,
                          // style: const TextStyle(color: Colors.transparent),
                          controller: _searchController,
                          onChanged: widget.onChangeHandler,
                          decoration: InputDecoration(
                            hintText: widget.placeholder ?? 'Search...',
                            hintStyle: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 14),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF8C8C8C),
                                      ),
                                      child: const Icon(
                                        Icons.search,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                ],
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 24,
                              minHeight: 24,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                          ),
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
    );
  }
}
