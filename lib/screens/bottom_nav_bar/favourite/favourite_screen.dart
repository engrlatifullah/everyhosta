import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyhosta/models/post_model.dart';
import 'package:everyhosta/models/user_model.dart';
import 'package:everyhosta/widgets/post_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade50,
        title:const  Text("Your Favorite"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          UserModel userModel=UserModel.fromDoc(snapshot.data!);
          var postIds=List<String>.from(userModel.favorite!);
          if(postIds.isEmpty){
            return const Center(
              child: Text("No Favorite Item Found"),
            );
          }
          return  StreamBuilder(
            stream: FirebaseFirestore.instance.collection("post").where(FieldPath.documentId,whereIn: postIds).snapshots(),
            builder: (context,postSnap){
              if(!postSnap.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                padding:const  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                itemCount: postSnap.data!.docs.length,
                itemBuilder: (context,index){
                  PostModel postModel=PostModel.fromDoc(postSnap.data!.docs[index]);
                  return PostCard(postModel: postModel);
                },
              );

            },
          );
        },
      ),
    );
  }
}

