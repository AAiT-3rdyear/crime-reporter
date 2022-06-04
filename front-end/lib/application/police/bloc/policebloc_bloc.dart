import 'package:bloc/bloc.dart';
import 'package:crime_reporter/infrastructure/repository/police_repositories.dart';
import 'package:equatable/equatable.dart';

part 'policebloc_event.dart';
part 'policebloc_state.dart';

class PoliceblocBloc extends Bloc<PoliceblocEvent, PoliceblocState> {
  final policeRepository = PoliceRepository();

  PoliceblocBloc() : super(PoliceblocInitial()) {
    on<GetOngoing>(_onOngoing);
    on<GetSolved>(_onSolved);
    on<GetReported>(_onReported);
    on<DeleteCrime>(_onDeleteCrime);
    on<MoveToOngoing>(_onMoveToOngoing);
    on<MoveToSolved>(_onMoveToSolved);
  }

  void _onOngoing(GetOngoing event, Emitter emit) async {
    emit(PoliceblocInitial());
    final ongoingCrimes = await policeRepository.getOngoingCrimes(event.user);
    try {
      emit(GetOngoingSucessful(crimeList: ongoingCrimes));
    } catch (e) {}
  }

  void _onSolved(GetSolved event, Emitter emit) async {
    emit(PoliceblocInitial());
    final solvedCrimes = await policeRepository.getSolvedCrimes(event.user);
    try {
      emit(GetSolvedSucessful(crimeList: solvedCrimes));
    } catch (e) {}
  }

  void _onReported(GetReported event, Emitter emit) async {
    emit(PoliceblocInitial());
    final reportedCrimes = await policeRepository.getReportedCrimes(event.msg);
    try {
      emit(GetReportedSucessful(crimeList: reportedCrimes));
    } catch (e) {}
  }

  void _onDeleteCrime(DeleteCrime event, Emitter emit) async {
    emit(PoliceblocInitial());
    final response = await policeRepository.deleteCrime(event.id);
    if (response.statusCode == 200) {
      emit(DeleteSucessfull());
    } else {
      emit(DeleteFailed());
    }
  }

  void _onMoveToOngoing(MoveToOngoing event, Emitter emit) async {
    emit(PoliceblocInitial());
    final response = await policeRepository.moveToOngoing(event.id);
    if (response.statusCode == 200) {
      emit(MoveSuccessfull());
    } else {
      emit(MoveFailed());
    }
  }

  void _onMoveToSolved(MoveToSolved event, Emitter emit) async {
    emit(PoliceblocInitial());
    final response = await policeRepository.moveToSolved(event.id);
    if (response.statusCode == 200) {
      emit(MoveSuccessfull());
    } else {
      emit(MoveFailed());
    }
  }
}
