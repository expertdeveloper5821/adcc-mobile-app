import 'package:adcc/core/services/token_storage_service.dart';
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

  int selectedReasonIndex = 3;
  final TextEditingController feedbackController = TextEditingController();

  final List<String> reasons = const [
    "Not Active Anymore",
    "Schedule Conflict",
    "Community Not Matching My Interest",
    "Found Another Community",
    "Temporary Break",
    "Other",
  ];

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  Future<void> _leaveCommunity() async {
    setState(() => isLoading = true);

    final reason = reasons[selectedReasonIndex];
    final feedback = feedbackController.text.trim();

    final communityId = widget.community.id;

    debugPrint("");
    debugPrint("=====================================");
    debugPrint("🚪 [Leave Community] Button Pressed");
    debugPrint("=====================================");

    // ✅ Check Community ID
    debugPrint("🆔 Community ID: $communityId");
    if (communityId.isEmpty) {
      debugPrint("❌ Community ID is EMPTY");
    } else {
      debugPrint("✅ Community ID FOUND");
    }

    // ✅ Reason + feedback
    debugPrint("📌 Selected Reason: $reason");
    debugPrint("📝 Feedback: ${feedback.isEmpty ? "EMPTY" : feedback}");

    // 🔥 UPDATED: Token checks - Firebase token pe focus
    final firebaseToken = await TokenStorageService.getFirebaseToken();
    final backendToken = await TokenStorageService.getAccessToken();
    final refreshToken = await TokenStorageService.getRefreshToken();

    debugPrint("");
    debugPrint("🔐 [Token Debug - UPDATED]");
    debugPrint("🔥 Firebase Token: ${firebaseToken == null ? "NULL" : "FOUND"}");
    debugPrint("🔑 Backend Token: ${backendToken == null ? "NULL" : "FOUND"}");
    debugPrint("🔁 Refresh Token: ${refreshToken == null ? "NULL" : "FOUND"}");

    // Optional: Print token values (NOT recommended for production)
    if (firebaseToken != null) {
      debugPrint("🔥 Firebase Token Value: ${firebaseToken.substring(0, 25)}...");
      // 🔥 Check if it's actually a Firebase token (starts with eyJhbGciOiJSUzI1Ni)
      final isFirebaseToken = firebaseToken.startsWith('eyJhbGciOiJSUzI1Ni');
      debugPrint("🔥 Is Actually Firebase Token: $isFirebaseToken");
    }
    if (backendToken != null) {
      debugPrint("🔑 Backend Token Value: ${backendToken.substring(0, 25)}...");
    }

    debugPrint("");
    debugPrint("🚪 [Leave Community] API Call Start...");
    debugPrint("➡️ communityId: $communityId");
    debugPrint("➡️ reason: $reason");
    debugPrint("➡️ feedback: ${feedback.isEmpty ? null : feedback}");

    final res = await _communitiesService.leaveCommunity(
      communityId: communityId,
      reason: reason,
      feedback: feedback.isEmpty ? null : feedback,
    );

    debugPrint("");
    debugPrint("📦 [Leave Community] API Final Result");
    debugPrint("✅ success: ${res.success}");
    debugPrint("📩 message: ${res.message}");
    debugPrint("🔢 statusCode: ${res.statusCode}");
    debugPrint("📦 data: ${res.data}");
    debugPrint("=====================================");
    debugPrint("");

    setState(() => isLoading = false);

    if (!mounted) return;

    if (res.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Community left successfully ✅")),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message ?? "Failed to leave community ❌"),
        ),
      );
    }
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
                  Positioned(
                    left: 26,
                    top: 42,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB11212),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                "Leave Community",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E1E1E),
                  height: 1.15,
                ),
              ),

              const SizedBox(height: 10),

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

              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Text(
                      "Reason:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ...List.generate(reasons.length, (index) {
                      final isSelected = selectedReasonIndex == index;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _ReasonTile(
                          title: reasons[index],
                          isSelected: isSelected,
                          onTap: () {
                            setState(() => selectedReasonIndex = index);
                          },
                        ),
                      );
                    }),

                    const SizedBox(height: 18),

                    const Text(
                      "Additional Feedback",
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
                          hintText: "Tell Us More....",
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
    final borderColor =
        isSelected ? const Color(0xFFB11212) : const Color(0xFFE7DECF);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5EDE0),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
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
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFB11212)
                      : const Color(0xFFBDBDBD),
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