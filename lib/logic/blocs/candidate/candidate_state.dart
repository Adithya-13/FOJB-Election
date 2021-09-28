part of 'candidate_bloc.dart';

abstract class CandidateState extends Equatable {
  const CandidateState();
  @override

  List<Object?> get props => [];
}

class CandidateInitial extends CandidateState {}

class CandidateLoading extends CandidateState {}

class CandidateEmpty extends CandidateState {}

class CandidateSuccess extends CandidateState {
  final BaseEntity entity;

  CandidateSuccess({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class CandidateFailure extends CandidateState {
  final String message;

  CandidateFailure({required this.message});
}