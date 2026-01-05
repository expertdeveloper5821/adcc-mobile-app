import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Section displaying route details in a custom grid layout:
/// - Left side (60%): 2x2 grid of 4 cards
/// - Right side (40%): 1 tall card spanning both rows
class RouteDetailsGridSection extends StatelessWidget {
  final Map<String, String> routeDetails;

  const RouteDetailsGridSection({
    super.key,
    required this.routeDetails,
  });

  @override
  Widget build(BuildContext context) {
    final entries = routeDetails.entries.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _LayoutConstants.horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(),
          const SizedBox(height: _LayoutConstants.titleSpacing),
          _buildGridLayout(entries),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return const Text(
      'Route Details',
      style: TextStyle(
        fontSize: _TextStyles.titleFontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildGridLayout(List<MapEntry<String, String>> entries) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLeftGrid(entries),
        const SizedBox(width: _LayoutConstants.cardSpacing),
        if (entries.length > _LayoutConstants.tallCardIndex)
          _buildTallCard(entries[_LayoutConstants.tallCardIndex]),
      ],
    );
  }

  Widget _buildLeftGrid(List<MapEntry<String, String>> entries) {
    return Expanded(
      flex: _LayoutConstants.leftFlex,
      child: Column(
        children: [
          _buildTopRow(entries),
          const SizedBox(height: _LayoutConstants.cardSpacing),
          _buildBottomRow(entries),
        ],
      ),
    );
  }

  Widget _buildTopRow(List<MapEntry<String, String>> entries) {
    return Row(
      children: [
        if (entries.isNotEmpty) ...[
          Expanded(
            child: RouteDetailCard(
              label: entries[0].key,
              value: entries[0].value,
            ),
          ),
          const SizedBox(width: _LayoutConstants.cardSpacing),
        ],
        if (entries.length > 1)
          Expanded(
            child: RouteDetailCard(
              label: entries[1].key,
              value: entries[1].value,
            ),
          ),
      ],
    );
  }

  Widget _buildBottomRow(List<MapEntry<String, String>> entries) {
    return Row(
      children: [
        if (entries.length > 2) ...[
          Expanded(
            child: RouteDetailCard(
              label: entries[2].key,
              value: entries[2].value,
            ),
          ),
          const SizedBox(width: _LayoutConstants.cardSpacing),
        ],
        if (entries.length > 3)
          Expanded(
            child: RouteDetailCard(
              label: entries[3].key,
              value: entries[3].value,
            ),
          ),
      ],
    );
  }

  Widget _buildTallCard(MapEntry<String, String> entry) {
    return Expanded(
      flex: _LayoutConstants.rightFlex,
      child: RouteDetailCard(
        label: entry.key,
        value: entry.value,
        isTall: true,
      ),
    );
  }
}

/// Individual card widget for displaying a route detail
class RouteDetailCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isTall;

  const RouteDetailCard({
    super.key,
    required this.label,
    required this.value,
    this.isTall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isTall ? _CardConstants.tallCardHeight : _CardConstants.regularCardHeight,
      padding: const EdgeInsets.all(_CardConstants.padding),
      decoration: BoxDecoration(
        color: AppColors.dustyRose,
        borderRadius: BorderRadius.circular(_CardConstants.borderRadius),
      ),
      child: isTall ? _buildTallCardContent() : _buildRegularCardContent(),
    );
  }

  Widget _buildRegularCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Star and label on same row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.star_outline,
              size: _CardConstants.starIconSize,
              color: AppColors.deepRed,
            ),
            SizedBox(width: _CardConstants.starLabelSpacing),
            Expanded(
              child: _buildLabel(),
            ),
          ],
        ),
        const SizedBox(height: _CardConstants.labelValueSpacing),
        // Value aligned with label (not star) - add padding equal to star width + spacing
        Padding(
          padding: EdgeInsets.only(
            left: _CardConstants.starIconSize + _CardConstants.starLabelSpacing,
          ),
          child: _buildValue(),
        ),
      ],
    );
  }

  Widget _buildTallCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Star at top
        const Icon(
          Icons.star_outline,
          size: _CardConstants.starIconSize,
          color: AppColors.deepRed,
        ),
        // Label and value at bottom
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(),
            const SizedBox(height: _CardConstants.labelValueSpacing),
            _buildValue(),
          ],
        ),
      ],
    );
  }

  Widget _buildLabel() {
    return Text(
      label,
      style: const TextStyle(
        fontSize: _TextStyles.labelFontSize,
        color: AppColors.charcoal,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildValue() {
    return Text(
      value,
      style: const TextStyle(
        fontSize: _TextStyles.valueFontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      ),
      maxLines: isTall ? _TextStyles.tallCardMaxLines : _TextStyles.regularCardMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Layout constants for the grid section
class _LayoutConstants {
  static const double horizontalPadding = 16.0;
  static const double titleSpacing = 12.0;
  static const double cardSpacing = 12.0;
  static const int leftFlex = 6;
  static const int rightFlex = 4;
  static const int tallCardIndex = 4;
}

/// Card-specific constants
class _CardConstants {
  static const double regularCardHeight = 100.0;
  static const double tallCardHeight = 212.0; // 2 * regularCardHeight + cardSpacing
  static const double padding = 12.0;
  static const double borderRadius = 12.0;
  static const double starIconSize = 15.0;
  static const double starLabelSpacing = 8.0;
  static const double labelValueSpacing = 4.0;
}

/// Text styling constants
class _TextStyles {
  static const double titleFontSize = 20.0;
  static const double labelFontSize = 10.0;
  static const double valueFontSize = 12.0;
  static const int regularCardMaxLines = 2;
  static const int tallCardMaxLines = 3;
}
