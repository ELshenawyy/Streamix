import 'package:flutter/material.dart';
import 'package:movie_app/core/global/resources/app_color.dart';
import 'package:provider/provider.dart';

import '../controllers/manager/theme_notifier.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Provider.of<ThemeNotifier>(context).themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            title: const Text("Dark Mode"),
            trailing: Switch(
              value: Provider.of<ThemeNotifier>(context).themeMode ==
                  ThemeMode.dark,
              onChanged: (value) {
                Provider.of<ThemeNotifier>(context, listen: false)
                    .toggleTheme(value ? ThemeMode.dark : ThemeMode.light);
              },
              activeTrackColor: Colors.red.shade100,
              activeColor: Colors.red,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About Us"),
            onTap: () {
              // Navigate to About Us page or show info
              showAboutDialog(
                context: context,
                applicationName: "Movie App",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2024 Your Company",
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text("Contact Us"),
            onTap: () {
              // Show contact options or navigate to contact screen
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Contact Us"),
                  content: const Text(
                      "Email: alshnawyahmd668@gmail.com\nPhone: +201200507628"),
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
