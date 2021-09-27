import 'package:fojb_election/data/entities/entities.dart';

class UserEntity extends BaseEntity {
  final String password;
  final String name;
  final String id;

  UserEntity({
    String? password,
    String? name,
    String? id,
  })  : password = password ?? '',
        name = name ?? '',
        id = id ?? '';

}
