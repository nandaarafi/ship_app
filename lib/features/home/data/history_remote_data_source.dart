
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ship_apps/features/home/domain/history_data_model.dart';

class HistoryRemoteDataSource {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userHistoryReference = FirebaseFirestore.instance
      .collection('history')
      ;


  Future<List<HistoryDataModel>> fetchHistoryData() async {
    try {
      QuerySnapshot result = await _userHistoryReference
          .orderBy('waktu', descending: true)
          .get();
      // QuerySnapshot result = await _userHistoryReference
      //     .orderBy(FieldPath.documentId, descending: true)
      //     .get();
      List<HistoryDataModel> historyDataList = result.docs.map((e) {
        return HistoryDataModel.fromJson(
            e.id, e.data() as Map<String, dynamic>);
      }).toList();
      print(historyDataList);
      return historyDataList;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createHistoryData(HistoryDataModel historyData) async {
    try {
      await _userHistoryReference.add(historyData.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteHistoryData(String historyId) async {
    try{
      await _userHistoryReference.doc(historyId).delete();
    } catch (e) {
      throw e;
    }
  }
}