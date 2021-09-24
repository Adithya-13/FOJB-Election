import 'package:fojb_election/data/entities/entities.dart';

class UserEntity extends BaseEntity {
  final String phoneNumber;
  final String password;
  final String name;
  final String id;

  UserEntity({
    String? phoneNumber,
    String? password,
    String? name,
    String? id,
  })  : phoneNumber = phoneNumber ?? '',
        password = password ?? '',
        name = name ?? '',
        id = id ?? '';

}
