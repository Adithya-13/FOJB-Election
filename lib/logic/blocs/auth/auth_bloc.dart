import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/data/repositories/repositories.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;
  final GetStorage _getStorage;

  AuthBloc({
    required UserRepository userRepository,
    required GetStorage getStorage,
  })  : _userRepository = userRepository,
        _getStorage = getStorage,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is PostAuth) {
      yield* _mapPostAuthToState(event);
    }
  }

  Stream<AuthState> _mapPostAuthToState(PostAuth event) async* {
    yield AuthLoading();
    try {
      final entity =
          await _userRepository.getUserByPhone(phoneNumber: event.phoneNumber);
      if(entity.id != '' && entity.password == event.password){
        await _getStorage.write(Keys.name, entity.name);
        await _getStorage.write(Keys.id, entity.id);
        await _getStorage.write(Keys.isLoggedIn, true);
        yield AuthSuccess(userEntity: entity);
      } else {
        yield AuthFailure(message: 'No Telp atau Password salah');
      }
    } catch (e, stacktrace) {
      yield AuthFailure(
        message: 'unable to post auth : $e, stacktrace: $stacktrace',
      );
    }
  }
}
