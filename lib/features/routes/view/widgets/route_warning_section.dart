import 'package:flutter/material.dart';
import '../../../../shared/widgets/warning_message.dart';

class RouteWarningSection extends StatelessWidget {
  const RouteWarningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return WarningMessage(
      message: 'Strong winds expected of Al Dhafra today choose sheltered routes',
      type: MessageType.warning,
    );
  }
}

