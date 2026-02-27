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
      backgroundColor: const Color(0xFFF4EFE6),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _sectionTitle("Account"),
            _cardContainer(
              children: [
                _arrowTile(
                  icon: Icons.person_outline,
                  title: "Edit Profile",
                  subtitle: "Update your personal information",
                ),
                _divider(),
                _arrowTile(
                  icon: Icons.directions_bike_outlined,
                  title: "Cycling Preferences",
                  subtitle: "Set your riding style & goals",
                ),
                _divider(),
                _arrowTile(
                  icon: Icons.warning_amber_outlined,
                  title: "Emergency Contacts",
                  subtitle: "Manage safety contacts",
                ),
              ],
            ),

            const SizedBox(height: 20),

            _sectionTitle("Notifications"),
            _cardContainer(
              children: [
                _switchTile(
                  title: "Event Reminders",
                  subtitle: "Get notified before events start",
                  value: eventReminders,
                  onChanged: (v) => setState(() => eventReminders = v),
                ),
                _divider(),
                _switchTile(
                  title: "Community Updates",
                  subtitle: "New posts and announcements",
                  value: communityUpdates,
                  onChanged: (v) => setState(() => communityUpdates = v),
                ),
                _divider(),
                _switchTile(
                  title: "New Messages",
                  subtitle: "Direct messages from riders",
                  value: newMessages,
                  onChanged: (v) => setState(() => newMessages = v),
                ),
                _divider(),
                _switchTile(
                  title: "Achievements",
                  subtitle: "When you unlock badges",
                  value: achievements,
                  onChanged: (v) => setState(() => achievements = v),
                ),
                _divider(),
                _switchTile(
                  title: "Weekly Report",
                  subtitle: "Your cycling activity summary",
                  value: weeklyReport,
                  onChanged: (v) => setState(() => weeklyReport = v),
                ),
              ],
            ),

            const SizedBox(height: 20),

        
            _sectionTitle("Privacy"),
            _cardContainer(
              children: [
                _switchTile(
                  title: "Public Profile",
                  subtitle: "Others can view your profile",
                  value: publicProfile,
                  onChanged: (v) => setState(() => publicProfile = v),
                ),
                _divider(),
                _switchTile(
                  title: "Show Statistics",
                  subtitle: "Display your cycling stats",
                  value: showStatistics,
                  onChanged: (v) => setState(() => showStatistics = v),
                ),
                _divider(),
                _switchTile(
                  title: "Share Location",
                  subtitle: "Share your city with others",
                  value: shareLocation,
                  onChanged: (v) => setState(() => shareLocation = v),
                ),
                _divider(),
                _switchTile(
                  title: "Activity Sharing",
                  subtitle: "Auto-share completed rides",
                  value: activitySharing,
                  onChanged: (v) => setState(() => activitySharing = v),
                ),
              ],
            ),

            const SizedBox(height: 20),

         
            _sectionTitle("App Preferences"),
            _cardContainer(
              children: [
                _arrowTile(
                  icon: Icons.language,
                  title: "Language",
                  subtitle: "English",
                ),
                _divider(),
                _arrowTile(
                  icon: Icons.straighten,
                  title: "Units",
                  subtitle: "Metric (km, kg)",
                ),
                _divider(),
                _arrowTile(
                  icon: Icons.map_outlined,
                  title: "Map Style",
                  subtitle: "Standard",
                ),
                _divider(),
                _switchTile(
                  title: "Dark Mode",
                  subtitle: "Coming soon",
                  value: darkMode,
                  onChanged: (v) => setState(() => darkMode = v),
                ),
              ],
            ),

            const SizedBox(height: 20),

     
            _cardContainer(
              children: [
                _arrowTile(
                  icon: Icons.help_outline,
                  title: "Help Center",
                ),
                _divider(),
                _arrowTile(
                  icon: Icons.description_outlined,
                  title: "Terms & Conditions",
                ),
                _divider(),
                _arrowTile(
                  icon: Icons.privacy_tip_outlined,
                  title: "Privacy Policy",
                ),
                _divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    "App Version\n1.0.0 (Build 10)",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }


  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _cardContainer({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDE5D8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, thickness: 0.6);
  }

  Widget _arrowTile({
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, size: 20),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(fontSize: 12),
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Switch(
        value: value,
        activeColor: Colors.red,
        onChanged: onChanged,
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}