import 'package:firebase_database/firebase_database.dart';

class PacketCapacityRemoteDataSource {
  final DatabaseReference _homeRealRef = FirebaseDatabase.instance.ref();

  Future<void> updateStatusPak({required Map<String, dynamic> data}) async {
    await _homeRealRef.update(data);
  }

  Stream<String> getStatusPaketStream() {
    return _homeRealRef.child('status-paket').onValue.map((event) {
      return event.snapshot.value.toString();
    });
  }
}