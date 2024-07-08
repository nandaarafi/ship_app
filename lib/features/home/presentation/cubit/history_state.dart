part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class AllHistorySuccess extends HistoryState {
  final List<HistoryDataModel> history;

  AllHistorySuccess(this.history);
  @override
  List<Object> get props => [history];
}

class DeleteHistorySuccess extends HistoryState {}

class HistoryFailed extends HistoryState {
  final String error;

  HistoryFailed(this.error);

  @override
  List<Object> get props => [error];
}


