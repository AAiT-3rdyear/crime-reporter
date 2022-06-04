part of 'policebloc_bloc.dart';

abstract class PoliceblocEvent extends Equatable {
  const PoliceblocEvent();

  @override
  List<Object> get props => [];
}

class GetReported extends PoliceblocEvent {
  dynamic msg;
  GetReported(this.msg);
}

class GetOngoing extends PoliceblocEvent {
  dynamic user;
  GetOngoing(this.user);
}

class GetSolved extends PoliceblocEvent {
  dynamic user;
  GetSolved(this.user);
}

class DeleteCrime extends PoliceblocEvent {
  dynamic id;
  DeleteCrime(this.id);
}

class MoveToOngoing extends PoliceblocEvent {
  dynamic id;
  MoveToOngoing(this.id);
}

class MoveToSolved extends PoliceblocEvent {
  dynamic id;
  MoveToSolved(this.id);
}
