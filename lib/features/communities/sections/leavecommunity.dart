// features/communities/sections/leave_community_screen.dart

import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/features/communities/services/communities_service.dart';
import 'package:adcc/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';

class LeaveCommunity extends StatefulWidget {
  final CommunityModel community;

  const LeaveCommunity({
    super.key,
    required this.community,
  });

  @override
  State<LeaveCommunity> createState() => _LeaveCommunityState();
}

class _LeaveCommunityState extends State<LeaveCommunity> {
  final CommunitiesService _communitiesService = CommunitiesService();
  
  bool isLoading = false;
  int selectedReasonIndex = -1; // Start with no reason selected
  final TextEditingController feedbackController = TextEditingController();
  
  late CommunityModel _community;

  final List<String> reasons = const [
    "Not Active Anymore",
    "Schedule Conflict",
    "Community Not Matching My Interest",
    "Found Another Community",
    "Temporary Break",
    "Other",
  ];

  @override
  void initState() {
    super.initState();
    _community = widget.community;
    
    debugPrint(' LeaveCommunity initState:');
    debugPrint('   Community: ${_community.title}');
    debugPrint('   Is Joined: ${_community.isJoined}');
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  Future<void> _leaveCommunity() async {
    // Validate that a reason is selected
    if (selectedReasonIndex == -1) {
      _showSnackBar(
        message: "Please select a reason for leaving",
        isError: true,
      );
      return;
    }
    
    setState(() => isLoading = true);

    final reason = reasons[selectedReasonIndex];
    final feedback = feedbackController.text.trim();

    final result = await _communitiesService.leaveCommunity(
      communityId: _community.id,
      reason: reason,
      feedback: feedback.isEmpty ? null : feedback,
    );

    if (!mounted) return;

    setState(() => isLoading = false);

    if (result.success) {
      // Show success message
      _showSnackBar(
        message: "You have left the community",
        isError: false,
      );
      
      // Return true to indicate successful leave
      Navigator.pop(context, true);
    } else {
      _showSnackBar(
        message: result.message ?? "Failed to leave community",
        isError: true,
      );
    }
  }

  void _showSnackBar({required String message, required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
          child: Column(
            children: [
              // Header with back button
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 36,
                    width: 36,
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
              ),
              
              const SizedBox(height: 18),
              
              // Icon
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 130,
                    width: 130,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Icon(
                    Icons.exit_to_app,
                    size: 70,
                    color: Color(0xFFB11212),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Title
              Text(
                "Leave ${_community.title}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E1E1E),
                  height: 1.15,
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Subtitle
              const Text(
                "We're sorry to see you go.\nYour feedback helps us improve.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B6B6B),
                  height: 1.35,
                ),
              ),
              
              const SizedBox(height: 18),
              
              // Reasons list
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Text(
                      "Reason for leaving:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Reason tiles
                    ...List.generate(reasons.length, (index) {
                      final isSelected = selectedReasonIndex == index;
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _ReasonTile(
                          title: reasons[index],
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              selectedReasonIndex = index;
                            });
                          },
                        ),
                      );
                    }),
                    
                    const SizedBox(height: 18),
                    
                    // Feedback section
                    const Text(
                      "Additional Feedback (Optional)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    Container(
                      height: 110,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5EDE0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: feedbackController,
                        maxLines: null,
                        expands: true,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Tell us more...",
                          hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9A9A9A),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Leave button
              AppButton(
                label: isLoading ? "Leaving..." : "Leave Community",
                onPressed: isLoading ? null : _leaveCommunity,
                type: AppButtonType.primary,
                backgroundColor: const Color(0xFFB11212),
                textColor: Colors.white,
                borderRadius: 16,
                height: 52,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reason Tile Widget
class _ReasonTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReasonTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5EDE0),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFFB11212) : const Color(0xFFE7DECF),
            width: isSelected ? 1.6 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            
            // Radio indicator
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFB11212) : const Color(0xFFBDBDBD),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFB11212),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}