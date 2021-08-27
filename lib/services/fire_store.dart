import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final Object uid;

  Database({required this.uid});

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _requests =
      FirebaseFirestore.instance.collection('requests');

  Future<void> addUserData(
      {required String email,
      required String fullName,
      required String phone,
      required String bloodGroup,
      required String city}) async {
    return await _users.doc(uid as String).set({
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'blood_group': bloodGroup,
      'city': city
    });
  }

  Future<void> getUserData() {
    return _users.get();
  }

  Future<void> addresquet(
      {required String bloodGroup,
      required String city,
      required String hospital,
      required Timestamp date}) async {
    var documentRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid as String)
        .get();
    String currentUserName = documentRef.data()!['full_name'];
    String currentUserPhone = documentRef.data()!['phone'];

    await _requests.add({
      'uid': uid,
      'name': currentUserName,
      'phone': currentUserPhone,
      'blood_group': bloodGroup,
      'city': city,
      'hospital': hospital,
      'date': date
    });
  }

  Stream<QuerySnapshot<Object?>> getresquets() {
    return _users.doc(uid as String).collection('resquets').snapshots();
  }
}
