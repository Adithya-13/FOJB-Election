import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/data/repositories/repositories.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

part 'vote_event.dart';

part 'vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  final FojbRepository _fojbRepository;
  final GetStorage _getStorage;

  VoteBloc(
      {required FojbRepository fojbRepository, required GetStorage getStorage})
      : _fojbRepository = fojbRepository,
        _getStorage = getStorage,
        super(VoteInitial()) {
    final String id = _getStorage.read(Keys.id);
    final String name = _getStorage.read(Keys.name);
    on<CheckCanVote>((event, emit) async {
      emit(VoteLoading());
      final bool isUserCanVote = await _fojbRepository.checkUserVote(id: id);
      print('isUserCanVote $isUserCanVote');
      emit(VoteCheck(isUserCanVote: isUserCanVote));
    });
    on<PostVote>((event, emit) async {
      emit(VoteLoading());
      try {
        final bool isUserCanVote = await _fojbRepository.checkUserVote(id: id);
        if (isUserCanVote) {
          _fojbRepository.doVote(
            position: event.position,
            name: name,
            id: id,
          );
          emit(VoteSuccess());
        } else {
          emit(VoteCheck(isUserCanVote: false));
        }
      } catch (e, stacktrace) {
        emit(VoteFailure(
            message: 'unable to Vote: $e, stacktrace: $stacktrace'));
      }
    });
  }
}
