import 'package:flutter/material.dart';
import '../../../../shared/widgets/warning_message.dart';

class RouteSafetySection extends StatelessWidget {
  final String safetyMessage;

  const RouteSafetySection({
    super.key,
    required this.safetyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: WarningMessage(
        title: 'Safety Information',
        message: safetyMessage,
        type: MessageType.warning,
      ),
    );
  }
}

