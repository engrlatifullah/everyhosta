import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../models/user_model.dart';
import '../screens/auth/login_screen.dart';
import '../screens/bottom_nav_bar/bottom_nav_bar.dart';
import '../utils/navigations.dart';

class AuthServices {
  static signUP({BuildContext? context,
    String? userName,
    String? email,
    String? password}) async {
    try {
      EasyLoading.show(status: "Please wait");
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      UserModel userModel = UserModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          userName: userName,
          favorite: [],
          email: email);
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userModel.toMap());

      navigateWithPush(context: context, pageName: const LoginScreen());
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.code.toString());
      EasyLoading.dismiss();
    }
  }

  static login({BuildContext? context,
    String? email,
    String? password}) async {
    try {
      EasyLoading.show(status: "Please wait");
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
      navigateWithPush(context: context, pageName: const BottomNavBar());
      EasyLoading.dismiss();
    } on FirebaseAuthException catch(e){
      EasyLoading.showError(e.code.toString());
      EasyLoading.dismiss();
    }
  }

  static logOut(context)async{
    EasyLoading.show(status: "Please wait");
    await FirebaseAuth.instance.signOut();
    EasyLoading.dismiss();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
      return LoginScreen();
    }), (route) => false);
  }
  static forgotPassword({required String email})async{
  try {
    EasyLoading.show(status: "Please wait");
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    EasyLoading.dismiss();
  } on FirebaseException catch(e){
    EasyLoading.showError(e.message.toString());
    EasyLoading.dismiss();
  }
  }
}
