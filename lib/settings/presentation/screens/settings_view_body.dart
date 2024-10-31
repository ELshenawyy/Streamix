import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/global/resources/app_color.dart';
import 'package:movie_app/search/presentation/controller/search_events.dart';
import 'package:movie_app/settings/presentation/screens/history_screen.dart';
import 'package:movie_app/settings/presentation/screens/privacy_policy.dart';
import 'package:provider/provider.dart';
import '../controllers/manager/theme_notifier.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(fontSize: 28, letterSpacing: 1.2),
        ),
      ),
      body: ListView(
        children: [
          // Dark Mode Toggle
          ListTile(
            leading: Icon(
              Provider.of<ThemeNotifier>(context).themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            title: Text(
              "Dark Mode",
              style: GoogleFonts.poppins(),
            ),
            trailing: Switch(
              value: darkMode,
              onChanged: (value) {
                Provider.of<ThemeNotifier>(context, listen: false)
                    .toggleTheme(value ? ThemeMode.dark : ThemeMode.light);
              },
              activeTrackColor: AppColors.gold.withOpacity(0.6),
              activeColor: AppColors.gold,
            ),
          ),
          const Divider(),

          // Account Settings


          // Notifications Settings
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: Text(
              "Notifications",
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              // Navigate to Notification Settings page
            },
          ),
          const Divider(),

          // Language Settings
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(
              "Language",
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              // Display Language Selection Options
            },
          ),
          const Divider(),

          // Privacy & Security
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(
              "Privacy & Security",
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.description),
                      title: const Text("Privacy Policy"),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PrivacyPolicyScreen()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.history),
                      title: const Text("Clear Search History"),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HistoryScreen()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.analytics_outlined),
                      title: const Text("Ads & Analytics Preferences"),
                      onTap: () {
                        // Navigate to Ads & Analytics screen
                      },
                    ),
                  ],
                ),
              );
            },
          ),

          const Divider(),

          // About
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(
              "About",
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Streamix",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2024 Streamix Inc.",
                applicationIcon: Image.asset(
                  'assets/icons/app_icon.png',
                  width: 48,
                  height: 48,
                ),
                barrierColor: darkMode
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.6),
              );
            },
          ),
          const Divider(),

          // Contact Us
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: Text(
              "Contact Us",
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              showDialog(
                barrierColor: darkMode
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.6),
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Contact Us",
                    style: GoogleFonts.poppins(
                        color: darkMode ? Colors.white : Colors.black),
                  ),
                  content: Text(
                    "Email: alshnawyahmd668@gmail.com\nPhone: +201200507628",
                    style: GoogleFonts.poppins(
                        color: darkMode ? Colors.white : Colors.black),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(),

          // App Version
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                "App Version 1.0.0",
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
