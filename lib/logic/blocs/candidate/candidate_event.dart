part of 'candidate_bloc.dart';

abstract class CandidateEvent extends Equatable {
  const CandidateEvent();

  @override
  List<Object?> get props => [];
}

class GetCandidates extends CandidateEvent {}

class GetCandidateByIndex extends CandidateEvent {
  final int id;

  GetCandidateByIndex({required this.id});

  @override
  List<Object?> get props => [id];
}
