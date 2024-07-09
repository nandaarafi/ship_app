import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:ship_apps/features/home/data/resi_remote_data_source.dart';

import '../../../core/routes/constants.dart';
import '../../../core/routes/routes.dart';
import '../presentation/provider/qr_code_provider.dart';


Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
  // AppRouter.router.go(Routes.profileNamedPage);

}
String parseTrackingNumber(String notificationBody) {
  try{
    RegExp regExp = RegExp(r'no resi: (\S+)');
    Match? match = regExp.firstMatch(notificationBody);
    if (match != null) {
      return match.group(1)!;
    }
    return "";
  } catch (e){
    throw e;
  }

}
class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;


  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This Channel is used for firebase notification',
    importance: Importance.defaultImportance,);

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> handleRemoteServerMessage(RemoteMessage? message) async {
    if (message == null) return;
    AppRouter.router.go(Routes.profileNamedPage);
    final qrCodeProvider = Provider.of<QrCodeProvider>(AppRouter.navigatorKey.currentContext!, listen: false);
    qrCodeProvider.setQrCode(true);
    String notifBody = parseTrackingNumber(message.notification!.body!);
    await ResiRemoteDataSource().getSpecificNoResiData(notifBody);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleRemoteServerMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleRemoteServerMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    //Do something when get a server message
    FirebaseMessaging.onMessage.listen( (message) {
      // handleMessage(message);
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@mipmap/launcher_icon',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }




  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    const settings = InitializationSettings(android: android);

    //Handling in App Notification and local
    await _localNotifications.initialize(
      settings,
      // Set the local notification when tapped, and
      // When app is openned notification tapped
      onDidReceiveNotificationResponse: (details) async {

        AppRouter.router.go(Routes.profileNamedPage);

        final qrCodeProvider = Provider.of<QrCodeProvider>(AppRouter.navigatorKey.currentContext!, listen: false);
        qrCodeProvider.setQrCode(true);

        Map<String, dynamic> payloadData = jsonDecode(details.payload!);
        String? body = payloadData['notification']?['body'];
        String notifBody = parseTrackingNumber(body!);
        await ResiRemoteDataSource().getSpecificNoResiData(notifBody);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }
  Future<String> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String devices = "${androidInfo.brand}--${androidInfo.device}";
    // print('Running on ${androidInfo.brand}');
    return devices;// e.g. "Moto G (4)"
  }
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    final deviceInfo = await getDeviceInfo();
    print("Token: $fCMToken");
    initPushNotifications();
    initLocalNotifications();
  }
}