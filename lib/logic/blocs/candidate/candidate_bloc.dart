import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/data/exceptions/failure.dart';
import 'package:fojb_election/data/repositories/repositories.dart';

part 'candidate_event.dart';

part 'candidate_state.dart';

class CandidateBloc extends Bloc<CandidateEvent, CandidateState> {
  final FojbRepository _fojbRepository;

  CandidateBloc({required FojbRepository fojbRepository})
      : _fojbRepository = fojbRepository,
        super(CandidateInitial()) {
    on<GetCandidates>((event, emit) async {
      emit(CandidateLoading());
      try {
        final CandidateEntity entity = await _fojbRepository.getCandidates();
        if (entity.candidates.isEmpty) {
          emit(CandidateEmpty());
          return;
        }
        emit(CandidateSuccess(entity: entity));
      } on Failure catch (e, stacktrace) {
        print(stacktrace);
        emit(CandidateFailure(
            message: 'unable to get Candidates : ${e.message}'));
      }
    });

    on<GetCandidateByIndex>((event, emit) async {
      emit(CandidateLoading());
      try {
        final CandidateItemEntity entity =
            await _fojbRepository.getCandidateByIndex(event.id);
        emit(CandidateByIndexSuccess(entity: entity));
      } on Failure catch (e, stacktrace) {
        print(stacktrace);
        emit(CandidateFailure(
            message: 'unable to get Candidate by Index : ${e.message}'));
      }
    });
  }
}
