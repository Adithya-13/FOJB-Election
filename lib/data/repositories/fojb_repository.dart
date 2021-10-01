import 'package:fojb_election/data/entities/count_entity.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/data/models/models.dart';
import 'package:fojb_election/data/providers/remotes/remotes.dart';
import 'package:fojb_election/data/utils/data_mapper.dart';
import 'package:fojb_election/data/utils/static_data.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

class FojbRepository {
  final UserDataSource _userDataSource;
  final VoteDataSource _voteDataSource;
  final CountDataSource _countDataSource;

  FojbRepository({
    required UserDataSource userDataSource,
    required VoteDataSource voteDataSource,
    required CountDataSource countDataSource,
  })  : _userDataSource = userDataSource,
        _voteDataSource = voteDataSource,
        _countDataSource = countDataSource;

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

  Future<bool> checkVoteTime() async {
    return _voteDataSource.checkVoteTime();
  }

  Future<CandidateEntity> getCandidates() async {
    final entity = StaticData.getCandidates();
    return entity;
  }

  Future<CandidateItemEntity> getCandidateByIndex(int index) async {
    final entity = StaticData.getCandidateByIndex(index);
    return entity;
  }

  Future<CountEntity> getCountAll() async {
    final total = await _countDataSource.getTotal();
    final first = await _countDataSource.getFirstCandidate();
    final second = await _countDataSource.getSecondCandidate();
    final third = await _countDataSource.getThirdCandidate();
    final fourth = await _countDataSource.getFourthCandidate();
    final fifth = await _countDataSource.getFifthCandidate();
    final sixth = await _countDataSource.getSixthCandidate();

    return CountEntity(
        total: total,
        countCandidates: [first, second, third, fourth, fifth, sixth]);
  }
}
