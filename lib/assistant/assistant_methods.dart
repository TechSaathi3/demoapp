import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taxi/global/global.dart';
import 'package:taxi/models/user_model.dart';

class AssistMethod {
  late UserModel UserModelCurrentInfo;

  Future<UserModel> readCurrentUserOnlineInfo() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('client')
          .doc(currentFirebaseUser!.uid)
          .get();

      if (snapshot.exists) {
        UserModelCurrentInfo = UserModel.fromSnapshot(snapshot);
        return UserModelCurrentInfo;
      } else {
       
        throw Exception('User data not found');
      }
    } catch (error) {
      print('Error reading current user online info: $error');

      throw Exception('Error reading user data');
    }
  }
}
