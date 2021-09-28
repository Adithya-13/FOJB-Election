import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'candidate_count_event.dart';
part 'candidate_count_state.dart';

class CandidateCountBloc extends Bloc<CandidateCountEvent, CandidateCountState> {
  CandidateCountBloc() : super(CandidateCountInitial()) {
    on<CandidateCountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
