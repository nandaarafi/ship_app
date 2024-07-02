import 'package:equatable/equatable.dart';

class ResiDataModel extends Equatable {
  final String? id;
  final String nama;
  final int noResi;
  final String status;

  ResiDataModel({
    this.id,
    required this.nama,
    required this.noResi,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'nama': nama,
      'noResi': noResi,
      'status': status,
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
