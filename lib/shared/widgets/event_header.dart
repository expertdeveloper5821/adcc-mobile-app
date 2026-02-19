import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class EventHeader extends StatefulWidget {
  final String imagePath;
  final String title;
  final String? subtitle;

  final bool wantSearchBar;
  final String? searchValue;
  final ValueChanged<String>? onChangeHandler;
  final String? placeholder;

  final bool showBackButton;
  final VoidCallback? onBackTap;

  const EventHeader({
    super.key,
    required this.imagePath,
    required this.title,
    this.subtitle,
    this.wantSearchBar = false,
    this.searchValue,
    this.onChangeHandler,
    this.placeholder,
    this.showBackButton = true,
    this.onBackTap,
  });

  @override
  State<EventHeader> createState() => _EventHeaderState();
}

class _EventHeaderState extends State<EventHeader> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchValue ?? '');
  }

  @override
  void didUpdateWidget(covariant EventHeader oldWidget) {
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

  void _handleBack() {
    if (widget.onBackTap != null) {
      widget.onBackTap!();
      return;
    }

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 306,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            /// Background Image (520w) + Left Shift (-81)
            Positioned(
              left: -81,
              top: 0,
              bottom: 0,
              child: Image.asset(
                widget.imagePath,
                width: 520,
                height: 306,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 520,
                    height: 306,
                    color: AppColors.softCream,
                  );
                },
              ),
            ),

            /// Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.05),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                  ),
                ),
              ),
            ),

            /// Back Button
            if (widget.showBackButton)
              Positioned(
                left: 14,
                top: 14,
                child: SafeArea(
                  bottom: false,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: _handleBack,
                      child: const SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: AppColors.deepRed,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            /// Content
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Title
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),

                  /// Subtitle
                  if (widget.subtitle != null && widget.subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      widget.subtitle!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],

                  /// Search Bar
                  if (widget.wantSearchBar) ...[
                    const SizedBox(height: 14),
                    Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: widget.onChangeHandler,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: InputDecoration(
                          hintText: widget.placeholder ??
                              "Search events, communities, cities, or tracks...",
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.70),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                          prefixIcon: Container(
                            margin: const EdgeInsets.all(10),
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.35),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.search,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
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
