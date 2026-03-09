import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AcceptedThoughtsSection extends StatelessWidget {
  final TextEditingController controller;

  const AcceptedThoughtsSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Thoughts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 159,
          decoration: BoxDecoration(
            color: Color(0XFFE9E4DB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Share details about your experience.',
              hintStyle: TextStyle(
                color: Color(0XFF33333366),
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            style: const TextStyle(
              color: AppColors.charcoal,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
