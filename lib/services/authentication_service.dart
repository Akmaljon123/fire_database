import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> registerUser({required String name, required String email, required String password})async{
    UserCredential user = await auth.createUserWithEmailAndPassword(email: email, password: password);
    await user.user?.updateDisplayName(name);
    if(user.user != null){
      return user.user;
    }else{
      return null;
    }
  }

  static Future<User?> loginUser({required String email, required String password})async{
    UserCredential user = await auth.signInWithEmailAndPassword(email: email, password: password);
    if(user.user != null){
      return user.user;
    }else{
      return null;
    }
  }

  static Future<void> editPassword(String password)async{
    User? user = auth.currentUser;

    if(user!=null){
      user.updatePassword(password);
    }
  }

  static Future<void> logout()async{
    await auth.signOut();
  }

  static Future<void> delete()async{
    User? user = auth.currentUser;

    if(user!=null){
      log("delete");
      await user.delete();
    }
  }
}