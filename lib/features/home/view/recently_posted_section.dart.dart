import 'package:flutter/material.dart';

class RecentlyPost extends StatelessWidget {
  const RecentlyPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// SECTION HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recently Posted",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text("View All"),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 18)
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 16),

          /// CARD LIST
          SizedBox(
            height: 253,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                RecentlyPostCard(),
                SizedBox(width: 16),
                RecentlyPostCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RecentlyPostCard extends StatelessWidget {
  const RecentlyPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172,
      height: 253,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE + SHARE BUTTON
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  "assets/images/bike.png",
                  width: 172,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.share,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// TITLE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Trek Domane",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 4),

          /// POSTED BY
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Posted by Mahmoud shaalan",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 6),

          /// PRICE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "7500 AED",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}