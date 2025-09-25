import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gowaroenk/service/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../bookmark/local_database_provider.dart';



class NotificationProvider extends ChangeNotifier {
  final NotificationService flutterNotificationService;

  NotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  static const int dailyReminderId = 100;
  bool? _permission = false;
  bool _dailyReminder = false;
  bool? get permission => _permission;
  bool get dailyReminder => _dailyReminder;
  bool bookmarkReminder = false;
  bool bigPictureReminder = false;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void showNotification() {
    _notificationId += 1;
    flutterNotificationService.showNotification(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new notification with id $_notificationId",
      payload: "This is a payload from notification with id $_notificationId",
    );
  }


  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _dailyReminder = prefs.getBool("dailyReminder") ?? false;
    bigPictureReminder = prefs.getBool("bigPictureReminder") ?? false;

    if (_dailyReminder) {
      await flutterNotificationService.scheduleDailyNotification(
        id: dailyReminderId,
      );
    }
    notifyListeners();
  }

  Future<void> toggleDailyReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    _dailyReminder = value;
    await prefs.setBool("dailyReminder", value);

    if (value) {
      await flutterNotificationService.scheduleDailyNotification(
        id: dailyReminderId,
      );
    } else {
      await flutterNotificationService.cancelNotification(dailyReminderId);
    }
    notifyListeners();
  }

  Future<void> toggleBookmarkReminder(
      bool value, LocalDatabaseProvider db) async {
    bookmarkReminder = value;
    notifyListeners();

    if (value) {
      final bookmarks = db.favorites;
      await flutterNotificationService.showBookmarkNotification(bookmarks);
    }
  }

  Future<void> toggleBigPictureReminder(bool value) async {
    bigPictureReminder = value;
    notifyListeners();

    if (value) {
      await flutterNotificationService.showRestaurantBigPictureNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        payload: '/main',
      );
      await Workmanager().registerPeriodicTask(
        "bigPictureTaskUnique",
        bigPictureTask,
        frequency: const Duration(minutes: 15),
        existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
      );
    } else {
      await Workmanager().cancelByUniqueName("bigPictureTaskUnique");
    }
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests =
    await flutterNotificationService.pendingNotificationRequests();
    notifyListeners();

    final messages = pendingNotificationRequests.isEmpty
        ? "Tidak ada notifikasi pending."
        : pendingNotificationRequests
        .map((e) => "ID: ${e.id}, Title: ${e.title}")
        .join("\n");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Pending Notifications"),
        content: Text(messages),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterNotificationService.cancelNotification(id);
  }

}
