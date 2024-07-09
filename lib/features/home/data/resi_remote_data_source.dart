
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../domain/resi_data_model.dart';

class ResiRemoteDataSource {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userResiReference = FirebaseFirestore.instance
      .collection('resiData');
  var logger = Logger();


  Future<List<ResiDataModel>> fetchResiData() async {
    try {
      QuerySnapshot result = await _userResiReference
          .orderBy('timestamp', descending: true)
          .get();
      List<ResiDataModel> resiDataList = result.docs.map((e) {
        return ResiDataModel.fromJson(
            e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return resiDataList;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createResiData(ResiDataModel resiData) async {
    try {
      await _userResiReference.add(resiData.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateResiData(String documentId, ResiDataModel resiData) async {
    try {
      await _userResiReference.doc(documentId).update(resiData.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateResiField(ResiDataModel resiData) async {
    try {
      await _userResiReference.doc(resiData.id).update({'status': 'Diterima'});
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteResiData(String resiId) async {
    try {
      await _userResiReference.doc(resiId).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<void> getSpecificNoResiData(String noResi) async {
    try {
      QuerySnapshot result = await _userResiReference
          .where('noResi', isEqualTo: noResi)
          .get();

      if (result.docs.isNotEmpty) {
        for (var doc in result.docs) {
          ResiDataModel resiData = ResiDataModel.fromJson(
              doc.id, doc.data() as Map<String, dynamic>);
          await updateResiField(resiData);
        }
      }
      logger.i("Update data with no resi ${noResi} Success");
    } catch (e) {
      logger.e(e);
      throw e;
    }
  }
}