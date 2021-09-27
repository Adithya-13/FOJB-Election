import 'package:firebase_database/firebase_database.dart';
import 'package:fojb_election/data/models/models.dart';

class UserDataSource {
  final DatabaseReference _ref;

  UserDataSource({
    required DatabaseReference ref,
  }) : _ref = ref;

  Future<User> getUserByPhone({required dynamic id}) async {
    User user = await _ref
        .child('users')
        .orderByChild('id')
        .equalTo(id)
        .once()
        .then<User>((DataSnapshot dataSnapshot) {
          print(dataSnapshot.value);
      if (dataSnapshot.value is List<Object?>) {
        print('this is list');
        print(dataSnapshot.value);
        if (dataSnapshot.exists) {
          return User.fromJson(dataSnapshot.value[0]);
        }
        return User();
      } else {
        if (dataSnapshot.exists) {
          Map<dynamic, dynamic> values = dataSnapshot.value;
          User? user;
          values.forEach((key, values) {
            user = User.fromJson(values);
          });
          return user ?? User();
        }
      }
      return User();
    });
    print(user.password);
    return user;
  }
}
