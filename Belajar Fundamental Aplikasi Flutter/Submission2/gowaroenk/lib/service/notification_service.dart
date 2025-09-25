import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../data/api/api_services.dart';
import '../data/model/restaurant.dart';


final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const String bigPictureTask = "bigPictureTask";


class NotificationService {
  final ApiServices _apiService = ApiServices();

  Future<void> init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        final payload = notificationResponse.payload;
        if (payload != null && payload.isNotEmpty) {
          selectNotificationStream.add(payload);
        }
      },
    );

  }

  Future<bool> _isAndroidPermissionGranted() async {
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled() ??
        false;
  }

  Future<bool> _requestAndroidNotificationsPermission() async {
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission() ??
        false;
  }
  Future<bool> _requestExactAlarmsPermission() async {
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission() ??
        false;
  }

  Future<bool?> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iOSImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      return await iOSImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final notificationEnabled = await _isAndroidPermissionGranted();
      final requestAlarmEnabled = await _requestExactAlarmsPermission();
      if (!notificationEnabled) {
        final requestNotificationsPermission =
        await _requestAndroidNotificationsPermission();
        return requestNotificationsPermission && requestAlarmEnabled;
      }
      return notificationEnabled && requestAlarmEnabled;
    } else {
      return false;
    }
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  tz.TZDateTime _nextInstanceOfElevenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> scheduleDailyNotification({
    required int id,
    String channelId = "3",
    String channelName = "Schedule Notification",
  }) async {
    try {
      final listResponse = await _apiService.getRestaurantList();
      if (listResponse.restaurants.isEmpty) return;

      final randomIndex = Random().nextInt(listResponse.restaurants.length);
      final restaurant = listResponse.restaurants[randomIndex];

      final String largeIconPath = await _apiService.downloadAndSaveFile(
        restaurant.pictureId,
        'restaurant_icon_${restaurant.id}.png',
      );

      final String bigPicturePath = await _apiService.downloadAndSaveFile(
        restaurant.pictureId,
        'restaurant_big_${restaurant.id}.jpg',
      );

      final bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        hideExpandedLargeIcon: true,
        contentTitle: 'Rekomendasi Restoran: ${restaurant.name}',
        summaryText: restaurant.city,
      );

      final androidDetails = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: 'Notifikasi rekomendasi restoran dengan gambar',
        importance: Importance.max,
        priority: Priority.high,
        largeIcon: FilePathAndroidBitmap(largeIconPath),
        styleInformation: bigPictureStyleInformation,
      );

      final iosDetails = DarwinNotificationDetails(
        attachments: [DarwinNotificationAttachment(bigPicturePath)],
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final datetimeSchedule = _nextInstanceOfElevenAM();
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Waktunya Makan Siang',
        'Cek rekomendasi restoran hari ini: ${restaurant.name}',
        datetimeSchedule,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      if (kDebugMode) print("Daily BigPicture Notification Error: $e");
    }
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    String channelId = "1",
    String channelName = "Simple Notification",
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> showBookmarkNotification(List<Restaurant> bookmarks) async {
    final count = bookmarks.length;
    await showNotification(
      id: 99,
      title: "Bookmark Anda",
      body: "Anda punya $count restoran favorit.",
      payload: "/bookmark",
    );
  }

  Future<void> showRestaurantBigPictureNotification({
    required int id,
    required String payload,
  }) async {
    try {
      // Ambil daftar restoran dari API
      final listResponse = await _apiService.getRestaurantList();
      if (listResponse.restaurants.isEmpty) return;

      // Pilih restoran secara acak
      final randomIndex = Random().nextInt(listResponse.restaurants.length);
      final restaurant = listResponse.restaurants[randomIndex];

      // Download gambar restoran
      final String largeIconPath = await _apiService.downloadAndSaveFile(
        restaurant.pictureId,
        'restaurant_icon_${restaurant.id}.png',
      );

      final String bigPicturePath = await _apiService.downloadAndSaveFile(
        restaurant.pictureId,
        'restaurant_big_${restaurant.id}.jpg',
      );

      final bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        hideExpandedLargeIcon: true,
        contentTitle: 'Rekomendasi Restoran: ${restaurant.name}',
        htmlFormatContentTitle: false,
        summaryText: restaurant.city,
        htmlFormatSummaryText: false,
      );

      final androidDetails = AndroidNotificationDetails(
        'bigpicture_channel',
        'Big Picture Notification',
        channelDescription: 'Notifikasi rekomendasi restoran dengan gambar',
        importance: Importance.max,
        priority: Priority.high,
        largeIcon: FilePathAndroidBitmap(largeIconPath),
        styleInformation: bigPictureStyleInformation,
      );

      final iosDetails = DarwinNotificationDetails(attachments: [
        DarwinNotificationAttachment(bigPicturePath),
      ]);

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        'Rekomendasi Restoran',
        restaurant.name,
        notificationDetails,
        payload: payload,
      );
    } catch (e) {
      if (kDebugMode) print("BigPicture Notification Error: $e");
    }
  }


  Future<List<PendingNotificationRequest>> pendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotificationRequests;
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

}