import 'package:adcc/features/profile/view/sections/settings/account_section.dart';
import 'package:adcc/features/profile/view/sections/settings/app_preferences_section.dart';
import 'package:adcc/features/profile/view/sections/settings/notifications_section.dart';
import 'package:adcc/features/profile/view/sections/settings/privacy_section.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool eventReminders = true;
  bool communityUpdates = true;
  bool newMessages = true;
  bool achievements = true;
  bool weeklyReport = false;

  bool publicProfile = true;
  bool showStatistics = true;
  bool shareLocation = false;
  bool activitySharing = true;

  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF4EFE6),
        centerTitle: true,
        title: const Text(
          "Settings & Preferences",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        leading: Padding(
    padding: const EdgeInsets.only(left: 12),
    child: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: Color(0xffE8B4B0), 
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Color(0xffC62828), 
          size: 20,
        ),
      ),
    ),
  ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
const AccountSection(),
            const SizedBox(height: 20),
NotificationsSection(
  eventReminders: eventReminders,
  communityUpdates: communityUpdates,
  newMessages: newMessages,
  achievements: achievements,
  weeklyReport: weeklyReport,

  onEventRemindersChanged: (v) => setState(() => eventReminders = v),
  onCommunityUpdatesChanged: (v) => setState(() => communityUpdates = v),
  onNewMessagesChanged: (v) => setState(() => newMessages = v),
  onAchievementsChanged: (v) => setState(() => achievements = v),
  onWeeklyReportChanged: (v) => setState(() => weeklyReport = v),
),
            const SizedBox(height: 20),

PrivacySection(
  publicProfile: publicProfile,
  showStatistics: showStatistics,
  shareLocation: shareLocation,
  activitySharing: activitySharing,

  onPublicProfileChanged: (v) => setState(() => publicProfile = v),
  onShowStatisticsChanged: (v) => setState(() => showStatistics = v),
  onShareLocationChanged: (v) => setState(() => shareLocation = v),
  onActivitySharingChanged: (v) => setState(() => activitySharing = v),
),

            const SizedBox(height: 20),
AppPreferencesSection(
  darkMode: darkMode,
  onDarkModeChanged: (v) => setState(() => darkMode = v),
),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }



}