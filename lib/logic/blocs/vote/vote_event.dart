part of 'vote_bloc.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object?> get props => [];
}

class PostVote extends VoteEvent {
  final int position;

  PostVote({required this.position});

  @override
  List<Object?> get props => [position];
}

class CheckCanVote extends VoteEvent {}