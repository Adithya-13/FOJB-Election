part of 'vote_bloc.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object?> get props => [];
}

class PostVote extends VoteEvent {
  final int position;
  final String name;
  final String id;

  PostVote({required this.position, required this.name, required this.id});

  @override
  List<Object?> get props => [position, name, id];
}

class CheckCanVote extends VoteEvent {
  final String id;
  CheckCanVote({required this.id});

  @override
  List<Object?> get props => [id];
}