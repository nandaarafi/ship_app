import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/packet_capacity_remote_data_source.dart';

part 'packet_state.dart';

class PacketCubit extends Cubit<PacketState> {
  PacketCubit() : super(PacketInitial());

  void fetchRealtimePacket() {
    emit(PacketLoading());
    PacketCapacityRemoteDataSource().getStatusPaketStream().listen((status) {
      emit(PacketStreamSuccess(status));
    }, onError: (e) {
      emit(PacketFailed(e.toString())
      );
    }
    );
  }
}
