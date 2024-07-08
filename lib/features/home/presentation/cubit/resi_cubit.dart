import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ship_apps/features/home/data/resi_remote_data_source.dart';

import '../../domain/resi_data_model.dart';

part 'resi_state.dart';

class ResiCubit extends Cubit<ResiState> {
  ResiCubit() : super(ResiInitial());

  void fetchAllResi() async {
    try {
      emit(ResiLoading());

      List<ResiDataModel> resiData =
      await ResiRemoteDataSource().fetchResiData();

      emit(AllResiSuccess(resiData));
    } catch (e) {
      emit(ResiFailed(e.toString()));
    }
  }
  void createNewResi({
    required String nama,
    required String noResi,
    required String status,
  }) async {
    try {
      emit(ResiLoading());
      ResiDataModel resiData = ResiDataModel(
        nama: nama,
        noResi: noResi,
        status: status,
      );
      await ResiRemoteDataSource().createResiData(resiData);
      emit(AddResiSuccess());
    } catch (e) {
      emit(ResiFailed(e.toString()));
    }
  }

  void deleteResi({
    required String resiId,
}) async {
    try{
      emit(ResiLoading());
      await ResiRemoteDataSource().deleteResiData(resiId);
      List<ResiDataModel> resiData = await ResiRemoteDataSource().fetchResiData();
      emit(AllResiSuccess(resiData));
    } catch (e) {
      emit(ResiFailed(e.toString()));
      throw e;
    }
  }
}


