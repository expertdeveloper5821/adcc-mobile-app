import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CommunityHeader extends StatefulWidget {
  final String imagePath;
  final String title;
  final bool wantSearchBar;

  final String? searchValue;
  final ValueChanged<String>? onChangeHandler;
  final String? placeholder;

  final bool showBackButton;
  final VoidCallback? onBackTap;

  const CommunityHeader({
    super.key,
    required this.imagePath,
    required this.title,
    this.wantSearchBar = true,
    this.searchValue,
    this.onChangeHandler,
    this.placeholder,
    this.showBackButton = true,
    this.onBackTap,
  });

  @override
  State<CommunityHeader> createState() => _CommunityHeaderState();
}

class _CommunityHeaderState extends State<CommunityHeader> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchValue ?? '');
  }

  @override
  void didUpdateWidget(covariant CommunityHeader oldWidget) {
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
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358,
      height: 306,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            /// Image
            Positioned.fill(
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.softCream,
                ),
              ),
            ),

            /// Gradient
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
                children: [
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
                              "Search by track name, city, distance or terrain...",
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
