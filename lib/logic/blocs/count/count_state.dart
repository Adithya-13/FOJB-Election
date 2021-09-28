part of 'count_bloc.dart';

abstract class CountState extends Equatable {
  const CountState();
  @override

  List<Object?> get props => [];
}

class CountInitial extends CountState {}

class CountLoading extends CountState {}

class CountEmpty extends CountState {}

class CountSuccess extends CountState {
  final CountEntity entity;

  CountSuccess({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class CountFailure extends CountState {
  final String message;

  CountFailure({required this.message});
}