import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyhosta/models/post_model.dart';
import 'package:everyhosta/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final PostModel postModel;

  const DetailsScreen({Key? key, required this.postModel}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.postModel.imageUrl!),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Plant Name",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.postModel.title!,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      DocumentSnapshot snap = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get();

                      if (snap['favorite'].contains(widget.postModel.docId)) {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "favorite":
                              FieldValue.arrayRemove([widget.postModel.docId!]),
                        });
                      } else {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "favorite":
                              FieldValue.arrayUnion([widget.postModel.docId!]),
                        });
                      }
                    },
                    child: Container(
                      height: 20,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          var data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          return data['favorite']
                                  .contains(widget.postModel.docId)
                              ? Icon(Icons.favorite, color: Colors.red[900])
                              : const Icon(Icons.favorite_border);
                        },
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.postModel.description!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
