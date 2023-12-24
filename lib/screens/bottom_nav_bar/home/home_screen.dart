import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyhosta/models/post_model.dart';
import 'package:everyhosta/screens/bottom_nav_bar/home/details_screen/details_screen.dart';
import 'package:everyhosta/utils/navigations.dart';
import 'package:flutter/material.dart';

import '../../../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: searchController,
            onChanged: (v) {
              setState(() {});
            },
            decoration: const InputDecoration(
              hintText: "Search",
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("post").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Data not available"),
                  );
                }

                if (searchController.text.isEmpty) {}

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,


                  itemBuilder: (_, index) {
                    PostModel postModel =
                        PostModel.fromDoc(snapshot.data!.docs[index]);
                    if (searchController.text.isEmpty) {
                      return PostCard(postModel: postModel);
                    } else if (postModel.title!
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                      return PostCard(postModel: postModel);
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

