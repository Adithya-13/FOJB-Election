import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fojb_election/data/exceptions/failure.dart';
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
      try{
        final bool isUserCanVote = await _fojbRepository.checkUserVote(id: event.id);
        print('isUserCanVote $isUserCanVote');
        emit(VoteCheck(isUserCanVote: isUserCanVote));
      } on Failure catch(e, stacktrace) {
        print(stacktrace);
        emit(VoteFailure(
            message: 'unable to Vote: ${e.message}'));
      }
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
      } on Failure catch (e, stacktrace) {
        print(stacktrace);
        emit(VoteFailure(
            message: 'unable to Vote: ${e.message}'));
      }
    });
  }
}
