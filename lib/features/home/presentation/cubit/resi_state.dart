part of 'resi_cubit.dart';

abstract class ResiState extends Equatable {
  const ResiState();
  @override
  List<Object> get props => [];
}

class ResiInitial extends ResiState {}

class ResiLoading extends ResiState {}

class AllResiSuccess extends ResiState {
  final List<ResiDataModel> resi;

  AllResiSuccess(this.resi);
  @override
  List<Object> get props => [resi];
}

class DeleteResiSuccess extends ResiState {}

class AddResiSuccess extends ResiState {
  // final ResiDataModel resi;
  // AddResiSuccess(this.resi);
  // @override
  // List<Object> get props => [resi];
}

class ResiFailed extends ResiState {
  final String error;

  ResiFailed(this.error);

  @override
  List<Object> get props => [error];
}
