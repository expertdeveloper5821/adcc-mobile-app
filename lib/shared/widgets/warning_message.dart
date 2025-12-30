import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


enum MessageType { warning, info, success, error }

class WarningMessage extends StatelessWidget {
  final String message;
  final MessageType type;

  const WarningMessage({
    super.key,
    required this.message,
    this.type = MessageType.warning,
  });

  Color get _backgroundColor {
    switch (type) {
      case MessageType.warning:
        return AppColors.paleGreen; // Green for warnings in your design
      case MessageType.info:
        return Colors.blue;
      case MessageType.success:
        return Colors.green;
      case MessageType.error:
        return Colors.red;
    }
  }

  IconData get _icon {
    switch (type) {
      case MessageType.warning:
        return Icons.warning_amber_rounded;
      case MessageType.info:
        return Icons.info_outline;
      case MessageType.success:
        return Icons.check_circle_outline;
      case MessageType.error:
        return Icons.error_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            _icon,
            color: Colors.black,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

