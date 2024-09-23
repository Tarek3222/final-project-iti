import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_devices/constants/strings.dart';
import 'package:market_devices/models/user_model.dart';

class CloudStoreUsers {
  CollectionReference allUsers =
      FirebaseFirestore.instance.collection(users);

   Future<void> addUser({required UserModel user}) {
    return allUsers.add({
      kName: user.name,
      kEmail: user.email,
      kPassword: user.password,
      kPhone: user.phone,
      kImage: user.image
    });
  }
  Future<void> updateUser({required UserModel user}) async{
    return await allUsers
        .doc(user.id)
        .update({
      kName: user.name,
      kEmail: user.email,
      kPassword: user.password,
      kPhone: user.phone,
      kImage: user.image
    });
  }

  Future<void> deleteUser({required String id}) async{  
    return await allUsers
        .doc(id)
        .delete();
  }
  Stream<QuerySnapshot> getAllUsers() {
    return allUsers
        .snapshots();
  }
}