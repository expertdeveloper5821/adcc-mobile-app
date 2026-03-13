import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/auth/view/register_screen.dart';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import './languageCard.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  void _goToCreateProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 12),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Image.asset(
              'assets/icons/arrowLeft.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Color.fromARGB(25, 140, 140, 140),
              shape: const CircleBorder(),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // Background Gradient
        decoration: const BoxDecoration(
          color: AppColors.softCream,
        ),

        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 36),

              // Language Icon
              Image.asset('assets/images/lang_icon.png', width: 58, height: 58),

              const SizedBox(height: 24),

              // Title
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    '${l10n.choose}\n${l10n.language}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: Colors.black,
                      height: 1.4,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Language Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LanguageCard(
                    image: 'assets/images/english_a.png',
                    label: 'ENGLISH',
                    isSelected: currentLocale == 'en',
                    onTap: () {
                      MyApp.setLocale(context, const Locale('en'));
                      _goToCreateProfile(context);
                    },
                  ),
                  const SizedBox(width: 24),
                  LanguageCard(
                    image: 'assets/images/arabic_a.png',
                    label: 'ARABIC',
                    isSelected: currentLocale == 'ar',
                    onTap: () {
                      MyApp.setLocale(context, const Locale('ar'));
                      _goToCreateProfile(context);
                    },
                  ),
                ],
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
