import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? phone;
  late String? name;
  late String? email;
  late String? id;

  UserModel({this.phone, this.name, this.id, this.email});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    phone = data?['phone'];
    name = data?['name'];
    id = snapshot.id;
    email = data?['email'];
  }

  static toJson(UserModel userModelCurrentInfo) {}
}