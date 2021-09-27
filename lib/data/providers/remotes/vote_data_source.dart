import 'package:firebase_database/firebase_database.dart';
import 'package:fojb_election/data/models/models.dart';

class VoteDataSource {
  final DatabaseReference _ref;

  VoteDataSource({
    required DatabaseReference ref,
  }) : _ref = ref;

  Future<bool> checkUserVote({required String id}) async {
    User? user = await _ref.child('data').child('total').orderByChild('id').equalTo(id).once().then<User?>((DataSnapshot dataSnapshot) {
      print('isUserCanVote: ' + dataSnapshot.value.toString());
      if(dataSnapshot.exists){
        Map<dynamic, dynamic> values = dataSnapshot.value;
        User? user;
        values.forEach((key,values) {
          print(values['id']);
          print(values['name']);
          user = User.fromJson(values);
        });
        return user ?? null;
      }
      return null;
    });
    return user == null;
  }

  Future<void> doVote(
      {required int position,
        required String name,
        required String id,
        int weight: 1}) async {
    for (int i = 0; i < weight; i++) {
      await _ref
          .child('data')
          .child(position.toString())
          .push()
          .set({"name": name, "id": id});

      await _ref
          .child('data')
          .child('total')
          .push()
          .set({"name": name, "id": id});
    }
  }
}
