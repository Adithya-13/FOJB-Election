import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/data/models/models.dart';
import 'package:fojb_election/data/providers/remotes/remotes.dart';
import 'package:fojb_election/data/utils/data_mapper.dart';

class UserRepository {
  final UserDataSource _userDataSource;

  UserRepository({
    required UserDataSource userDataSource,
  }) : _userDataSource = userDataSource;

  Future<UserEntity> getUserByPhone({required String phoneNumber}) async {
    final User user =
        await _userDataSource.getUserByPhone(phoneNumber: phoneNumber);

    return DataMapper.userMapper(user: user);
  }
}
