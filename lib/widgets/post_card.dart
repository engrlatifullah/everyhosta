


import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../screens/bottom_nav_bar/home/details_screen/details_screen.dart';
import '../utils/navigations.dart';
class PostCard extends StatelessWidget {
  final PostModel postModel;

  const PostCard({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        navigateWithPush(
          context: context,
          pageName: DetailsScreen(postModel: postModel),
        );
      },
      child: Container(
          margin: const  EdgeInsets.symmetric(vertical: 10),
          height: MediaQuery.of(context).size.height*0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(postModel.imageUrl!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.srcATop,
                ),
              )),
          child: Center(
            child: Text(
              postModel.title!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          )),
    );
  }
}