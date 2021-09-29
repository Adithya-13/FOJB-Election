import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:fojb_election/data/exceptions/failure.dart';
import 'package:fojb_election/data/models/models.dart';

class UserDataSource {
  final DatabaseReference _ref;

  UserDataSource({
    required DatabaseReference ref,
  }) : _ref = ref;

  Future<User> getUserByPhone({required dynamic id}) async {
    try{
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
      }).catchError((error) {
        throw Failure(error);
      }).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Failure('time out connection');
        },
      );
      return user;
    } on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the User");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }
}
