part of 'count_bloc.dart';

abstract class CountEvent extends Equatable {
  const CountEvent();

  @override
  List<Object?> get props => [];
}

class GetCounts extends CountEvent {}
