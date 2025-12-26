import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum AppButtonType {
  primary,
  secondary,
  text,
  danger,
}

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;

  /// Icons
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  /// Layout
  final double height;
  final double? width;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;

  /// Styling
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double borderWidth;
  final double elevation;
  final TextStyle? textStyle;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,

    this.prefixIcon,
    this.suffixIcon,

    this.height = 48,
    this.width,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = 12,

    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 1,
    this.elevation = 0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = onPressed == null || isLoading;

    return Padding(
      padding: margin,
      child: SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: _buildButton(context, disabled),
      ),
    );
  }

  Widget _buildButton(BuildContext context, bool disabled) {
    switch (type) {
      case AppButtonType.secondary:
        return OutlinedButton(
          onPressed: disabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            padding: padding,
            side: BorderSide(
              color: borderColor ?? Theme.of(context).primaryColor,
              width: borderWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: _content(context),
        );

      case AppButtonType.text:
        return TextButton(
          onPressed: disabled ? null : onPressed,
          style: TextButton.styleFrom(
            padding: padding,
          ),
          child: _content(context),
        );

      case AppButtonType.danger:
        return ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.deepRed,
            elevation: elevation,
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: _content(context, defaultTextColor: Colors.white),
        );

      case AppButtonType.primary:
      default:
        return ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                backgroundColor ?? Theme.of(context).primaryColor,
            elevation: elevation,
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: _content(context, defaultTextColor: Colors.white),
        );
    }
  }

  Widget _content(BuildContext context, {Color? defaultTextColor}) {
    if (isLoading) {
      return const SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    final Color resolvedTextColor =
        textColor ?? defaultTextColor ?? Theme.of(context).primaryColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon, size: 20, color: resolvedTextColor),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: textStyle ??
              TextStyle(
                color: resolvedTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
        ),
        if (suffixIcon != null) ...[
          const SizedBox(width: 8),
          Icon(suffixIcon, size: 20, color: resolvedTextColor),
        ],
      ],
    );
  }
}
