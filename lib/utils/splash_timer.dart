import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/auth/login_screen.dart';
import '../screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'navigations.dart';

splashTimer(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  Timer(const Duration(seconds: 3), () {
    if (user == null) {
      navigateWithPush(
        context: context,
        pageName: const LoginScreen(),
      );
    } else {
      navigateWithPush(
        context: context,
        pageName: const BottomNavBar(),
      );
    }
  });
}
