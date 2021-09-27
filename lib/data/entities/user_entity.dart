import 'package:fojb_election/data/entities/entities.dart';

class UserEntity extends BaseEntity {
  final String password;
  final String name;
  final String id;
  final String phoneNumber;
  final String type;

  UserEntity({
    String? password,
    String? name,
    String? id,
    String? phoneNumber,
    String? type,
  })  : password = password ?? '',
        name = name ?? '',
        phoneNumber = phoneNumber ?? '',
        type = type ?? '',
        id = id ?? '';

}
