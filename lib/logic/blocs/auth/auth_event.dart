part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class PostAuth extends AuthEvent {
  final String phoneNumber;
  final String password;

  PostAuth({required this.phoneNumber, required this.password});

  @override
  List<Object> get props => [phoneNumber, password];
}
