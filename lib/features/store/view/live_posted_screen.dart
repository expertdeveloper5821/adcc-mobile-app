import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/adaptive_image.dart';
import 'listings_screen.dart';

class LivePostedScreen extends StatelessWidget {
  final String? title;
  final String? price;
  final String? imagePath;

  const LivePostedScreen({Key? key, this.title, this.price, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        backgroundColor: AppColors.softCream,
        elevation: 0,
        leading: Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: Navigator.of(context).canPop()
                ? () => Navigator.of(context).pop()
                : null,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.deepRed.withValues(alpha: 0.1),
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
            // Decorative red ring positioned behind the card
            Positioned(
              left: -120,
              top: 160,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.deepRed,
                    width: 18,
                  ),
                ),
              ),
            ),
            // Overlay to hide the bottom half of the ring so only the top border shows
            Positioned(
              left: -120,
              top: 270,
              child: Container(
                width: 220,
                height: 110, 
                color: AppColors.softCream,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  // decorative circle
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
                                color: AppColors.charcoal.withValues(alpha: 0.04),
                                blurRadius: 12,
                              ),
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

                  const SizedBox(height: 24),
                  const Text(
                    'Your item is live',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You have successfully posted listing',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textDark.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 34),

                  // Listing card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightPeach,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AdaptiveImage(
                            imagePath: imagePath ?? 'assets/images/cycling_1.png',
                            width: 72,
                            height: 64,
                            fit: BoxFit.cover,
                            placeholderColor: AppColors.charcoal.withValues(alpha: 0.06),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title ?? 'Untitled',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                price ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.deepRed,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Posted by 2mins ago',
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
                      label: 'View Listing',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ListingsScreen(imagePath: imagePath)),
                      ),
                      type: AppButtonType.primary,
                      backgroundColor: AppColors.deepRed,
                      textColor: Colors.white,
                      height: 50,
                      borderRadius: 10,
                    ),
                  ),

                  const SizedBox(height: 12),

                  AppButton(
                    label: 'Post Another Item',
                    onPressed: () => Navigator.pop(context),
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
