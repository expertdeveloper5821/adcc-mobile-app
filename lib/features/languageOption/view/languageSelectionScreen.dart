import 'package:adcc/features/auth/view/communityScreen/community.dart';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import './languageCard.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CommunityScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // Background Gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF6ED), Color.fromARGB(255, 213, 234, 250)],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Language Icon
              Image.asset('assets/images/lang_icon.png', width: 48, height: 48),

              const SizedBox(height: 24),

              // Title
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 80,
                      height: 25,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 255, 250, 243),
                            Color.fromARGB(255, 246, 226, 192),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${l10n.choose.toUpperCase()}\n${l10n.language.toUpperCase()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
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
                    onTap: () {
                      MyApp.setLocale(context, const Locale('en'));
                      _goToLogin(context);
                    },
                  ),

                  const SizedBox(width: 24),

                  LanguageCard(
                    image: 'assets/images/arabic_a.png',
                    label: 'ARABIC',
                    onTap: () {
                      MyApp.setLocale(context, const Locale('ar'));
                      _goToLogin(context);
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
