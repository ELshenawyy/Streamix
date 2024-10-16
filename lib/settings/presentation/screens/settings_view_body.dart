import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/global/resources/app_color.dart';
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
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(
              "About",
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              // Navigate to About Us page or show info
              showAboutDialog(
                  context: context,
                  applicationName: "MovieMania",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2024 Movie Mania Inc.",
                  applicationIcon: Image.asset(
                    'assets/icons/app_icon_updated.png',
                    width: 48,
                    height: 48,
                  ),
                  barrierColor: darkMode
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.6));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: Text(
              "Contact Us",
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              // Show contact options or navigate to contact screen
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
        ],
      ),
    );
  }
}
