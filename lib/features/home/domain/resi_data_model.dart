import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ResiDataModel extends Equatable {
  final String? id;
  final String nama;
  final String noResi;
  final String status;

  ResiDataModel({
    this.id,
    required this.nama,
    required this.noResi,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'noResi': noResi,
      'status': status,
      'timestamp': FieldValue.serverTimestamp()
    };
  }
  factory ResiDataModel.fromJson(String id, Map<String, dynamic> json) {
    return ResiDataModel(
      id: id,
      nama: json['nama'],
      noResi: json['noResi'],
      status: json['status'],
    );
  }
  @override
  List<Object?> get props => [id, nama, noResi, status];
}
