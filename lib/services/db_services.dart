import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyhosta/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

class DbServices {
  static uploadData({required BuildContext context ,required String imageUrl,required String title,required String description }) async {
    try {
      var docId=const Uuid().v4();
      EasyLoading.show(status: "Please wait");
      Reference storage = FirebaseStorage.instance
          .ref()
          .child("images/${DateTime.now().microsecondsSinceEpoch}");
      final uploadTask = storage.putFile(File(imageUrl));
      final snapshot = await uploadTask!.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      PostModel postModel =
      PostModel(imageUrl: url, docId: docId, title: title,description: description,
      uid: FirebaseAuth.instance.currentUser!.uid,

      );
      await FirebaseFirestore.instance
          .collection("post").doc(
        docId
      ).set(postModel.toMap());
      EasyLoading.dismiss();
      Navigator.pop(context);

    } on FirebaseException catch (e) {
      EasyLoading.showError(e.code);
      EasyLoading.dismiss();
    }
  }

  // static deletePhoto(String id) async {
  //  try {
  //    EasyLoading.show(status: "Please wait");
  //    await FirebaseFirestore.instance
  //        .collection(FireStoreConstant.usersCollection)
  //        .doc(FirebaseAuth.instance.currentUser!.uid)
  //        .collection(FireStoreConstant.imagesCollection)
  //        .doc(id)
  //        .delete();
  //
  //    EasyLoading.dismiss();
  //  }
  //  on FirebaseException catch(e){
  //    EasyLoading.showError(e.code);
  //    EasyLoading.dismiss();
  //  }
  // }
}
