import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/adaptive_image.dart';
import 'listings_screen.dart';

class LivePostedScreen extends StatelessWidget {
  final String? title;
  final String? price;
  final String? imagePath;

  const LivePostedScreen({
    super.key,
    this.title,
    this.price,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,

      /// APPBAR
      appBar: AppBar(
        backgroundColor: AppColors.softCream,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.pop(context);
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.deepRed.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.deepRed,
                size: 20,
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: [

            /// FRAME IMAGE (NO PADDING)
            Positioned(
               left: -52,
              top: 188,
              child: Image.asset(
                "assets/images/frame_1.png",
                width: 135,
                fit: BoxFit.contain,
              ),
            ),

            /// MAIN CONTENT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(height: 12),

                  /// TOP DECORATIVE CIRCLE
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.charcoal.withValues(alpha: 0.05),
                                blurRadius: 12,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          left: 18,
                          top: 18,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: AppColors.deepRed,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  /// TITLE
                  const Text(
                    "Your item is live",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: AppColors.charcoal,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  /// SUBTITLE (2 LINES)
                  Text(
                    "You have successfully\nposted listing",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textDark.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  /// LISTING CARD
                  Container(
                    width: 357,
                    height: 135,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDDA8),
                      borderRadius: BorderRadius.circular(20.7),
                      border: Border.all(
                        color: const Color(0xFFFFDDA8),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [

                        /// IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AdaptiveImage(
                            imagePath: imagePath ?? "assets/images/cycling_1.png",
                            width: 100.5,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 16),

               
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                title ?? "Untitled",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textDark,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                price ?? "",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.charcoal,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "Posted by 2mins ago",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textDark.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: "View Listing",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ListingsScreen(
                              imagePath: imagePath,
                            ),
                          ),
                        );
                      },
                      type: AppButtonType.primary,
                      backgroundColor: AppColors.deepRed,
                      textColor: Colors.white,
                      height: 50,
                      borderRadius: 10,
                    ),
                  ),

                  const SizedBox(height: 12),

             
                  AppButton(
                    label: "Post Another Item",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.white,
                    borderColor: AppColors.deepRed,
                    textColor: AppColors.deepRed,
                    height: 50,
                    borderRadius: 10,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}