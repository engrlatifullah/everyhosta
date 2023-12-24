import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? uid;
    String? docId;
   String? imageUrl;
   String? title;
   String? description;

  PostModel(
      { this.docId,
       this.imageUrl,
       this.title,
        this.uid,
       this.description});

  Map<String, dynamic> toMap() {
    return {
      "docId": docId,
      'uid':uid,
      "imageUrl": imageUrl,
      "title": title,
      "description": description
    };
  }

  factory PostModel.fromDoc(DocumentSnapshot snapshot) {
    return PostModel(
      uid: snapshot['uid'],
      docId: snapshot["docId"],
      imageUrl: snapshot["imageUrl"],
      title: snapshot["title"],
      description: snapshot["description"],
    );
  }
}
