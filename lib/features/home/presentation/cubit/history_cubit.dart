import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ship_apps/features/home/data/history_remote_data_source.dart';
import 'package:ship_apps/features/home/domain/history_data_model.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  void fetchAllHistory() async {
    try {
      emit(HistoryLoading());

      List<HistoryDataModel> historyData =
      await HistoryRemoteDataSource().fetchHistoryData();

      emit(AllHistorySuccess(historyData));
    } catch (e) {
      emit(HistoryFailed(e.toString()));
    }
  }

  void deleteHistoryData({
    required String historyId,
}) async {
    try{
      emit(HistoryLoading());
      await HistoryRemoteDataSource().deleteHistoryData(historyId);
      emit(DeleteHistorySuccess());
    } catch (e) {
      emit(HistoryFailed(e.toString()));
      throw e;
    }
  }
}
