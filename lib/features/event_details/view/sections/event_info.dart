import 'package:flutter/material.dart';
import 'package:adcc/core/theme/app_colors.dart';

class EventInfo extends StatelessWidget {
  const EventInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            "Who Can Join",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: AppColors.charcoal,
            ),
          ),

          const SizedBox(height: 10),

      
          Container(
            width: 358,
            height: 79,
            padding: const EdgeInsets.fromLTRB(19, 16, 38, 16),
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                /// Left Column
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _JoinItem(text: "Age: 18+"),
                      SizedBox(height: 10),
                      _JoinItem(text: "Helmet required"),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                /// Right Column
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _JoinItem(text: "Road bike mandatory"),
                      SizedBox(height: 10),
                      _JoinItem(text: "Advanced experience"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _JoinItem extends StatelessWidget {
  final String text;

  const _JoinItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
     
        Container(
          height: 18,
          width: 18,
          decoration: const BoxDecoration(
            color: Color(0xFF3A3A3A),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.check,
              size: 12,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.charcoal.withValues(alpha: 0.80),
            ),
          ),
        ),
      ],
    );
  }
}
