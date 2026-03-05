import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MyCommunitiesSection extends StatelessWidget {
  const MyCommunitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.softCream,
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "My Communities",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.charcoal,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.charcoal,
                    ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 16),

 
          SizedBox(
            height: 273,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                return const _CommunityCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityCard extends StatelessWidget {
  const _CommunityCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358,
      height: 273,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11.5872),
        child: Container(
          color: const Color(0xFFFFF3E2),
          child: Column(
            children: [

      
              SizedBox(
                width: 358,
                height: 178.6592,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.4581),
                    topRight: Radius.circular(10.4581),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [

                      /// IMAGE
                      Image.asset(
                        "assets/images/cycling_1.png",
                        fit: BoxFit.cover,
                      ),

                      /// Overlay
                      Container(
                        color: Colors.black.withOpacity(0.10),
                      ),

                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.45),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            "Joined",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

           
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Abu Dhabi Road Racers",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.charcoal,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Weekly high-pace road rides & race training",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          height: 1.25,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.groups_2_outlined,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "2,800 members",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}