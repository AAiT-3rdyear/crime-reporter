part of 'policebloc_bloc.dart';

abstract class PoliceblocState extends Equatable {
  const PoliceblocState();
  @override
  List<Object> get props => [];
}

class PoliceblocInitial extends PoliceblocState {}

class GetOngoingSucessful extends PoliceblocState {
  final crimeList;
  GetOngoingSucessful({this.crimeList});
}

class GetOngoingFailed extends PoliceblocState {}

class GetReportedSucessful extends PoliceblocState {
  final crimeList;
  GetReportedSucessful({this.crimeList});
}

class GetReportedFailed extends PoliceblocState {}

class GetSolvedSucessful extends PoliceblocState {
  final crimeList;
  GetSolvedSucessful({this.crimeList});
}

class GetSolvedFailed extends PoliceblocState {}

class DeleteSucessfull extends PoliceblocState {}

class DeleteFailed extends PoliceblocState {}

class MoveSuccessfull extends PoliceblocState {}

class MoveFailed extends PoliceblocState {}
