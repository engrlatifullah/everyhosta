

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String ? uid;
  final String ? userName;
  final String ? email;
  final List? favorite;
  const UserModel({this.favorite, this.uid, this.userName, this.email});

  Map<String , dynamic> toMap(){
    return {
      "uid":uid,
      "userName" : userName,
      "email" : email,
      "favorite" : favorite
    };
  }

  factory UserModel.fromDoc(DocumentSnapshot document){
    return UserModel(
      uid: document["uid"],
      userName: document["userName"],
      email: document["email"],
      favorite: document["favorite"],
    );
  }
}