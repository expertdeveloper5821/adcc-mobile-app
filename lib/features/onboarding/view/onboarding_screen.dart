import 'package:adcc/features/languageOption/view/languageSelectionScreen.dart';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onButtonPressed() {
    if (_currentPage < 2 - 1) {
      // Move to next slide
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last slide - navigate to login
      _navigateToLogin();
    }
  }

  void _skipToLogin() {
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LanguageSelectionScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final slides = [
      OnboardingData(
        title: l10n.onboardingTitle1,
        description: l10n.onboardingDesc1,
        buttonText: l10n.next,
        imagePath: 'assets/images/onboarding_bg_one.png',
      ),
      OnboardingData(
        title: l10n.onboardingTitle2,
        description: l10n.onboardingDesc2,
        buttonText: l10n.getStarted,
        imagePath: 'assets/images/onboarding_bg_two.png',
      ),
    ];
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: slides.length,
            itemBuilder: (context, index) {
              return OnboardingSlide(
                data: slides[index],
              );
            },
          ),

          // Skip Button (always visible)
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: _skipToLogin,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 125,
            left: 0,
            right: 0,
            child: _buildPaginationDots(2),
          ),

          // Static Button
          Positioned(
              bottom: 0,
              left: 24,
              right: 24,
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      backgroundColor: AppColors.deepRed,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Builder(
                            builder: (context) {
                              final l10n = AppLocalizations.of(context)!;
                              final slides = [
                                OnboardingData(
                                    title: l10n.onboardingTitle1,
                                    description: l10n.onboardingDesc1,
                                    buttonText: l10n.next,
                                    imagePath:
                                        'assets/images/onboarding_bg_one.png'),
                                OnboardingData(
                                    title: l10n.onboardingTitle2,
                                    description: l10n.onboardingDesc2,
                                    buttonText: l10n.getStarted,
                                    imagePath:
                                        'assets/images/onboarding_bg_two.png'),
                              ];
                              return Text(
                                slides[_currentPage].buttonText,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          width: 44,
                          height: 44,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/right_arrow_head.png',
                              width: 16,
                              height: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPaginationDots(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? AppColors.deepRed : Colors.white,
          ),
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String buttonText;
  final String imagePath;

  OnboardingData({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.imagePath,
  });
}

class OnboardingSlide extends StatelessWidget {
  final OnboardingData data;

  const OnboardingSlide({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            data.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Placeholder if image not found
              return Container(
                color: Colors.grey[300],
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.grey[600],
                  ),
                ),
              );
            },
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.5),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),

        SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      data.title.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "Outfit",
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      data.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Outfit",
                          fontSize: 13,
                          height: 1.2,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 160),
            ],
          ),
        ),
      ],
    );
  }
}
