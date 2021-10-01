import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:fojb_election/data/exceptions/failure.dart';
import 'package:fojb_election/data/models/models.dart';

class VoteDataSource {
  final DatabaseReference _ref;

  VoteDataSource({
    required DatabaseReference ref,
  }) : _ref = ref;

  Future<bool> checkVoteTime() async {
    try{
      final bool isCanVote = await _ref.child('time').once().then((dataSnapshot) {
        if (dataSnapshot.exists) {
          Map<dynamic, dynamic> value = dataSnapshot.value;
          final start = value['start'];
          final end = value['end'];
          final dateStart = DateTime.fromMillisecondsSinceEpoch(start).toLocal();
          final dateEnd = DateTime.fromMillisecondsSinceEpoch(end).toLocal();
          final DateTime now = DateTime.now();
          return now.isBefore(dateEnd) && now.isAfter(dateStart);
        }
        return false;
      }).catchError((error) {
        throw Failure(error);
      }).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Failure('time out connection');
        },
      );
      return isCanVote;
    } on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the User");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }

  Future<bool> checkUserVote({required String id}) async {
    try {
      User? user = await _ref
          .child('data')
          .child('total')
          .orderByChild('id')
          .equalTo(id)
          .once()
          .then<User?>((DataSnapshot dataSnapshot) {
        print('isUserCanVote: ' + dataSnapshot.value.toString());
        if (dataSnapshot.exists) {
          Map<dynamic, dynamic> values = dataSnapshot.value;
          User? user;
          values.forEach((key, values) {
            print(values['id']);
            print(values['name']);
            user = User.fromJson(values);
          });
          return user ?? null;
        }
        return null;
      }).catchError((error) {
        throw Failure(error);
      }).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Failure('time out connection');
        },
      );
      return user == null;
    } on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the User");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }

  Future<void> doVote(
      {required int position,
      required String name,
      required String id,
      int weight: 1}) async {
    try {
      for (int i = 0; i < weight; i++) {
        await _ref
            .child('data')
            .child(position.toString())
            .push()
            .set({"name": name, "id": id}).catchError((error) {
          throw Failure(error);
        }).timeout(
          Duration(seconds: 15),
          onTimeout: () {
            throw Failure('time out connection');
          },
        );

        await _ref
            .child('data')
            .child('total')
            .push()
            .set({"name": name, "id": id}).catchError((error) {
          throw Failure(error);
        }).timeout(
          Duration(seconds: 15),
          onTimeout: () {
            throw Failure('time out connection');
          },
        );
      }
    } on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the User");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }
}
