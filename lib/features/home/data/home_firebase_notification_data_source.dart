
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeFirebaseNotificationDataSource{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  // CollectionReference _usersRefrence = FirebaseFirestore.instance.collection('users');

  Future<void> addFcmTokenToFirestore({
    required String? token,
    required DateTime? dateTime,
  }) async {
    try {
      CollectionReference fcmTokensRef = FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('fcmTokens');

      QuerySnapshot querySnapshot = await fcmTokensRef
          .where('token', isEqualTo: token)
          .get();

      String deviceInfo = await getDeviceInfo();
      if (querySnapshot.docs.isEmpty) {
        // No duplicates found, proceed to add the new data
        await fcmTokensRef.add({
          'token': token,
          'timestamps': dateTime,
          'deviceType': deviceInfo
        });
      } else {
        print('Document with the same token already exists.');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<String> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String devices = "${androidInfo.brand}--${androidInfo.device}";
    // print('Running on ${androidInfo.brand}');
    return devices;// e.g. "Moto G (4)"
  }
}
