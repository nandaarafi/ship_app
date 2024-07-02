part of 'packet_cubit.dart';

abstract class PacketState extends Equatable {
  const PacketState();
  @override
  List<Object> get props => [];
}

class PacketInitial extends PacketState {}

class PacketLoading extends PacketState {}

class PacketStreamSuccess extends PacketState {

  final String packet;

  PacketStreamSuccess(this.packet);
  @override
  List<Object> get props => [packet];
}

class PacketFailed extends PacketState{
  final String error;

  PacketFailed(this.error);
  @override
  List<Object> get props => [error];
}
