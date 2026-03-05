import 'package:flutter/material.dart';

class PerformanceInsightsCard extends StatelessWidget {
  const PerformanceInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      height: 158,
      decoration: BoxDecoration(
        color: const Color(0xffD4AA27),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        
          Row(
            children:  [
Image.asset(
                  "assets/icons/achive.png", 
                  width: 16,
                  height: 16,
                  fit: BoxFit.contain,
                  
                ),
              SizedBox(width: 8),
              Text(
                "Performance Insights",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// BOXES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _InsightBox(
                title: "Average\nCompletion Rate",
                value: "92%",
              ),
              _InsightBox(
                title: "Average Event\nDistance",
                value: "34.5 km",
              ),
              _InsightBox(
                title: "Best Category",
                value: "90%",
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _InsightBox extends StatelessWidget {
  final String title;
  final String value;

  const _InsightBox({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 80,
      padding: const EdgeInsets.only(
        top: 10,
        right: 3,
        bottom: 10,
        left: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffFFF3E2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black54,
             
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}