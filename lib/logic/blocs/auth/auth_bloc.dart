import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/data/exceptions/failure.dart';
import 'package:fojb_election/data/repositories/repositories.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FojbRepository _userRepository;
  final GetStorage _getStorage;

  AuthBloc({
    required FojbRepository fojbRepository,
    required GetStorage getStorage,
  })  : _userRepository = fojbRepository,
        _getStorage = getStorage,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is Login) {
      yield* _mapLoginToState(event);
    } else if (event is Logout) {
      yield* _mapLogoutToState(event);
    }
  }

  Stream<AuthState> _mapLoginToState(Login event) async* {
    yield AuthLoading();
    try {
      final entity = await _userRepository.getUserByPhone(id: event.id);
      if (entity.id != '' && entity.password == event.password) {
        await _getStorage.write(Keys.name, entity.name);
        await _getStorage.write(Keys.id, entity.id);
        await _getStorage.write(Keys.phoneNumber, entity.phoneNumber);
        await _getStorage.write(Keys.type, entity.type);
        await _getStorage.write(Keys.isLoggedIn, true);
        yield AuthSuccess(userEntity: entity);
      } else {
        yield AuthFailure(message: 'No Telp atau Password salah');
      }
    } on Failure catch (e, stacktrace) {
      print(stacktrace);
      yield AuthFailure(
        message: 'unable to login : ${e.message}',
      );
    }
  }

  Stream<AuthState> _mapLogoutToState(Logout event) async* {
    yield AuthLoading();
    try {
      await _getStorage.erase();
      await _getStorage.remove(Keys.id);
      await _getStorage.remove(Keys.name);
      await _getStorage.remove(Keys.phoneNumber);
      await _getStorage.remove(Keys.type);
      await _getStorage.remove(Keys.isLoggedIn);
      yield LogoutSuccess();
    } on Failure catch (e, stacktrace) {
      print(stacktrace);
      yield AuthFailure(
        message: 'unable to logout : ${e.message}',
      );
    }
  }
}
