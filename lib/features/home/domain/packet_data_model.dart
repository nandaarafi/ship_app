import 'package:equatable/equatable.dart';

class PacketDataModel extends Equatable {
  final String statusPaket;

  PacketDataModel({
    required this.statusPaket,
  });

  @override
  List<Object?> get props => [statusPaket];
}