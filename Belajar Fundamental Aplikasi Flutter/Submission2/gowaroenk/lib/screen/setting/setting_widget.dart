import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gowaroenk/main.dart';
import 'package:gowaroenk/provider/setting/notification_provider.dart';

import 'package:gowaroenk/provider/bookmark/local_database_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final notifProvider = Provider.of<NotificationProvider>(context); // <-- Tambahkan ini

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Theme"),
            subtitle: const Text("Aktifkan Mode Gelap/Terang"),
            value: themeProvider.isDarkMode,
            onChanged: (value) => themeProvider.toggleTheme(value),
          ),
          SwitchListTile(
            title: const Text("Notification"),
            subtitle: const Text("Aktifkan atau nonaktifkan semua notifikasi"),
            value: notifProvider.permission ?? false,
            onChanged: (value) async {
              await notifProvider.requestPermissions();
            },
          ),
          SwitchListTile(
            title: const Text("Daily Reminder"),
            subtitle: const Text("Ingatkan makan siang jam 11:00"),
            value: notifProvider.dailyReminder,
            onChanged: (value) async {
              await notifProvider.toggleDailyReminder(value);
            },
          ),
          SwitchListTile(
            title: const Text("Bookmark Notification"),
            subtitle: const Text("Tampilkan jumlah bookmark Anda"),
            value: notifProvider.bookmarkReminder,
            onChanged: (value) async {
              final db = Provider.of<LocalDatabaseProvider>(context, listen: false);
              await notifProvider.toggleBookmarkReminder(value, db);
            },
          ),
          SwitchListTile(
            title: const Text("Notif Rekomendasi Resto"),
            subtitle: const Text("Tampilkan rekomendasi restoran untuk Anda ...."),
            value: notifProvider.bigPictureReminder,
            onChanged: (val) async {
              await notifProvider.toggleBigPictureReminder(val);
            },
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final provider = context.read<NotificationProvider>();
                await provider.checkPendingNotificationRequests(context);
              },
              child: const Text(
                "Check pending notifications",
                textAlign: TextAlign.center,
              ),
            ),
          ),


          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Tentang Aplikasi"),
            subtitle: const Text("Versi 1.0.0"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Gowaroenk",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2025 Gowaroenk App",
              );
            },
          ),
        ],
      ),
    );
  }
}
