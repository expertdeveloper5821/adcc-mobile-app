import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/features/communities/sections/community_list_card.dart';
import 'package:adcc/features/communities/sections/community_type_details.dart';
import 'package:flutter/material.dart';

class Mycommunity extends StatelessWidget {
  final List<CommunityModel> myCommunities;

  const Mycommunity({
    super.key,
    required this.myCommunities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
          child: Column(
            children: [
              /// TOP BAR
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE6DA),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "My Communities",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 38),
                ],
              ),

              const SizedBox(height: 18),

              /// LIST (SAME CommunityListCard)
              Expanded(
                child: myCommunities.isEmpty
                    ? const Center(
                        child: Text(
                          "No communities found",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: myCommunities.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final community = myCommunities[index];

                          return CommunityListCard(
                            community: community,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CommunityCityDetails(
                                    community: community,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
