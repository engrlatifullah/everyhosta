import 'package:everyhosta/screens/bottom_nav_bar/favourite/favourite_screen.dart';
import 'package:everyhosta/services/auth_services.dart';
import 'package:everyhosta/utils/navigations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_post/add_post.dart';
import 'home/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeScreen(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: auth.currentUser!.email == "admin123@gmail.com"
            ? () {
                navigateWithPush(
                  context: context,
                  pageName: const AddPostScreen(),
                );
              }
            : () {
                navigateWithPush(
                  context: context,
                  pageName: const FavoriteScreen(),
                );
              },
        child: Icon(
          auth.currentUser!.email == "admin123@gmail.com"
              ? Icons.add
              : Icons.favorite_sharp,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.none,
        // height: 70,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.home,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    size: 30,
                  ),
                  onPressed: () {
                    AuthServices.logOut(context);
                  },
                ),
              ],
            )),
      ),
    );
  }
}
