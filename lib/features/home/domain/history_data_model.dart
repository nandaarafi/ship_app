import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class HistoryDataModel extends Equatable {
  final String? id;
  final String nama;
  final String waktu;
  final String status;

  HistoryDataModel({
    this.id,
    required this.nama,
    required this.waktu,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'waktu': FieldValue.serverTimestamp(),
      'status': status,
    };
  }
  factory HistoryDataModel.fromJson(String id, Map<String, dynamic> json) {
    return HistoryDataModel(
      id: id,
      nama: json['nama'],
      waktu: json['waktu'] ,
      status: json['status'],
    );
  }
  @override
  List<Object?> get props => [id, nama, waktu, status];
}
