import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/data/exceptions/failure.dart';
import 'package:fojb_election/data/repositories/repositories.dart';

part 'count_event.dart';
part 'count_state.dart';

class CountBloc extends Bloc<CountEvent, CountState> {
  final FojbRepository _fojbRepository;

  CountBloc({required FojbRepository fojbRepository})
      : _fojbRepository = fojbRepository,
        super(CountInitial()) {

    on<GetCounts>((event, emit) async {
      emit(CountLoading());
      try{
        final entity = await _fojbRepository.getCountAll();
        emit(CountSuccess(entity: entity));
      } on Failure catch (e, stacktrace){
        emit(CountFailure(message: 'unable to get counts: ${e.message}'));
      }
    });
  }
}
