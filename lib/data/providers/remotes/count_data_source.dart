import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:fojb_election/data/exceptions/failure.dart';

class CountDataSource {
  final DatabaseReference _ref;

  CountDataSource({
    required DatabaseReference ref,
  }) : _ref = ref;


  Future<int> getTotal() async {
    try{
      int total = await _ref.child('data').child('total').once().then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.exists) {
          Map<dynamic, dynamic> values = dataSnapshot.value;
          return values.length;
        }
        return 0;
      }).catchError((error) {
        throw Failure(error);
      }).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Failure('time out connection');
        },
      );
      return total;
    } on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the total");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }

  Future<int> getFirstCandidate() async {
    try{
      int total = await _ref.child('data').child('1').once().then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.exists) {
          Map<dynamic, dynamic> values = dataSnapshot.value;
          return values.length;
        }
        return 0;
      }).catchError((error) {
        throw Failure(error);
      }).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Failure('time out connection');
        },
      );
      return total;
    }on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the User");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }

  Future<int> getSecondCandidate() async {
    try{
      int total = await _ref.child('data').child('2').once().then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.exists) {
          Map<dynamic, dynamic> values = dataSnapshot.value;
          return values.length;
        }
        return 0;
      }).catchError((error) {
        throw Failure(error);
      }).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Failure('time out connection');
        },
      );
      return total;
    }on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the User");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }

  Future<int> getThirdCandidate() async {
    try{
      int total = await _ref.child('data').child('3').once().then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.exists) {
          Map<dynamic, dynamic> values = dataSnapshot.value;
          return values.length;
        }
        return 0;
      }).catchError((error) {
        throw Failure(error);
      }).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Failure('time out connection');
        },
      );
      return total;
    }on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the User");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }

  Future<int> getFourthCandidate() async {
    try{
      int total = await _ref.child('data').child('4').once().then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.exists) {
          Map<dynamic, dynamic> values = dataSnapshot.value;
          return values.length;
        }
        return 0;
      }).catchError((error) {
        throw Failure(error);
      }).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Failure('time out connection');
        },
      );
      return total;
    }on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the User");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }

  Future<int> getFifthCandidate() async {
    try{
      int total = await _ref.child('data').child('5').once().then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.exists) {
          Map<dynamic, dynamic> values = dataSnapshot.value;
          return values.length;
        }
        return 0;
      }).catchError((error) {
        throw Failure(error);
      }).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Failure('time out connection');
        },
      );
      return total;
    }on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the User");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }

  Future<int> getSixthCandidate() async {
    try{
      int total = await _ref.child('data').child('6').once().then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.exists) {
          Map<dynamic, dynamic> values = dataSnapshot.value;
          return values.length;
        }
        return 0;
      }).catchError((error) {
        throw Failure(error);
      }).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Failure('time out connection');
        },
      );
      return total;
    }on SocketException {
      throw Failure('No Internet connection!');
    } on HttpException {
      throw Failure("Couldn't find the User");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }

}