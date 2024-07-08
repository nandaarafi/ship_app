
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/resi_data_model.dart';

class ResiRemoteDataSource {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userResiReference = FirebaseFirestore.instance
                            .collection('resiData');


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

  Future<void> deleteResiData(String resiId) async{
    try{
      await _userResiReference.doc(resiId).delete();
    } catch (e) {
      throw e;
    }
  }
}