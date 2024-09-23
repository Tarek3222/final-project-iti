import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
 final FirebaseAuth auth=FirebaseAuth.instance;
 Future<UserCredential>signUp({required String email,required String password})async{
  final user = await auth.createUserWithEmailAndPassword(email: email, password: password);
  return user;
 }
 Future<UserCredential>signIn({required String email,required String password})async{
  final user = await auth.signInWithEmailAndPassword(email: email, password: password);
  return user;
 }
 Future<void>signOut()async{
  await auth.signOut();
 }
}