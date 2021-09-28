import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/data/models/models.dart';
import 'package:fojb_election/data/providers/remotes/remotes.dart';
import 'package:fojb_election/data/utils/data_mapper.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

class FojbRepository {
  final UserDataSource _userDataSource;
  final VoteDataSource _voteDataSource;

  FojbRepository({
    required UserDataSource userDataSource,
    required VoteDataSource voteDataSource,
  })  : _userDataSource = userDataSource,
        _voteDataSource = voteDataSource;

  Future<UserEntity> getUserByPhone({required String id}) async {
    dynamic idUser = id.isNumeric ? int.tryParse(id) : id;
    print('repository');
    final User user = await _userDataSource.getUserByPhone(id: idUser);

    return DataMapper.userMapper(user: user);
  }

  Future<void> doVote(
      {required int position,
      required String name,
      required String id,
      int weight: 1}) async {
    return _voteDataSource.doVote(
        position: position, name: name, id: id, weight: 1);
  }

  Future<bool> checkUserVote({required String id}) async {
    return _voteDataSource.checkUserVote(id: id);
  }
}
