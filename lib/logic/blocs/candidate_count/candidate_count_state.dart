part of 'candidate_count_bloc.dart';

abstract class CandidateCountState extends Equatable {
  const CandidateCountState();
}

class CandidateCountInitial extends CandidateCountState {
  @override
  List<Object> get props => [];
}
