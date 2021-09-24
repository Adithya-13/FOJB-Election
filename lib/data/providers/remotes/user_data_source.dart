import 'package:firebase_database/firebase_database.dart';
import 'package:fojb_election/data/models/models.dart';

class UserDataSource {
  final DatabaseReference _ref;

  UserDataSource({
    required DatabaseReference ref,
  })  : _ref = ref;

  Future<User> getUserByPhone({required String phoneNumber}) async {
    User user = await _ref.once().then<User>((DataSnapshot dataSnapshot) {
      ListUser listUser = ListUser.fromJson(dataSnapshot.value);
      User? user;
      for(var item in listUser.users!){
        if(item.id == phoneNumber){
          user = item;
          break;
        }
      }
      return user ?? User();
    });
    print(user.id);
    print(user.password);
    return user;
  }
}
