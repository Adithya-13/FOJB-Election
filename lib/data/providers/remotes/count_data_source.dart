import 'package:firebase_database/firebase_database.dart';

class CountDataSource {
  final DatabaseReference _ref;

  CountDataSource({
    required DatabaseReference ref,
  }) : _ref = ref;


  Future<int> getTotal() async {
    int total = await _ref.child('data').child('total').once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.exists) {
        Map<dynamic, dynamic> values = dataSnapshot.value;
        return values.length;
      }
      return 0;
    });
    return total;
  }

  Future<int> getFirstCandidate() async {
    int total = await _ref.child('data').child('1').once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.exists) {
        Map<dynamic, dynamic> values = dataSnapshot.value;
        return values.length;
      }
      return 0;
    });
    return total;
  }

  Future<int> getSecondCandidate() async {
    int total = await _ref.child('data').child('2').once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.exists) {
        Map<dynamic, dynamic> values = dataSnapshot.value;
        return values.length;
      }
      return 0;
    });
    return total;
  }

  Future<int> getThirdCandidate() async {
    int total = await _ref.child('data').child('3').once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.exists) {
        Map<dynamic, dynamic> values = dataSnapshot.value;
        return values.length;
      }
      return 0;
    });
    return total;
  }

  Future<int> getFourthCandidate() async {
    int total = await _ref.child('data').child('4').once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.exists) {
        Map<dynamic, dynamic> values = dataSnapshot.value;
        return values.length;
      }
      return 0;
    });
    return total;
  }

  Future<int> getFifthCandidate() async {
    int total = await _ref.child('data').child('5').once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.exists) {
        Map<dynamic, dynamic> values = dataSnapshot.value;
        return values.length;
      }
      return 0;
    });
    return total;
  }

  Future<int> getSixthCandidate() async {
    int total = await _ref.child('data').child('6').once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.exists) {
        Map<dynamic, dynamic> values = dataSnapshot.value;
        return values.length;
      }
      return 0;
    });
    return total;
  }

}