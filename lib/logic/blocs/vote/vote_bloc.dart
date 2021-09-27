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
    on<CheckCanVote>((event, emit) async {
      emit(VoteLoading());
      final bool isUserCanVote = await _fojbRepository.checkUserVote(id: event.id);
      print('isUserCanVote $isUserCanVote');
      emit(VoteCheck(isUserCanVote: isUserCanVote));
    });
    on<PostVote>((event, emit) async {
      emit(VoteLoading());
      try {
        final bool isUserCanVote = await _fojbRepository.checkUserVote(id: event.id);
        if (isUserCanVote) {
          await _fojbRepository.doVote(
            position: event.position,
            name: event.name,
            id: event.id,
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
