part of 'vote_bloc.dart';

abstract class VoteState extends Equatable {
  const VoteState();

  @override
  List<Object> get props => [];
}

class VoteInitial extends VoteState {}

class VoteLoading extends VoteState {}

class VoteSuccess extends VoteState {}

class VoteFailure extends VoteState {
  final String message;

  VoteFailure({required this.message});
}

class VoteCheck extends VoteState {
  final bool isUserCanVote;

  VoteCheck({required this.isUserCanVote});
}