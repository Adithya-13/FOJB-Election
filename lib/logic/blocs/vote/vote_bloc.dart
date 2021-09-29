import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fojb_election/data/repositories/repositories.dart';

part 'vote_event.dart';

part 'vote_state.dart';
mixin HomeVote on Bloc<VoteEvent, VoteState> {}

mixin DetailVote on Bloc<VoteEvent, VoteState> {}

mixin VotingVote on Bloc<VoteEvent, VoteState> {}

class VoteBloc extends Bloc<VoteEvent, VoteState> with HomeVote, DetailVote, VotingVote {
  final FojbRepository _fojbRepository;

  VoteBloc(
      {required FojbRepository fojbRepository})
      : _fojbRepository = fojbRepository,
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
