import 'package:everyhosta/screens/auth/login_screen.dart';
import 'package:everyhosta/services/auth_services.dart';
import 'package:everyhosta/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../widgets/custom_text_input.dart';
import '../../widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 140),
              const Text(
                "Every Hosta",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
               CustomTextInput(
                controller: userNameController,
                title: "UserName",
                icon: Icons.person,
              ),
              const SizedBox(height: 25),
               CustomTextInput(
                 controller: emailController,
                title: "Email",
                icon: Icons.email,
              ),
              const SizedBox(height: 25),
               CustomTextInput(
                controller: passwordController,
                title: "Password",
                icon: Icons.lock,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                onPressed: () async {
                 if (userNameController.text.isEmpty || userNameController.text == ''){
                   EasyLoading.showError("Username is required");
                 } else  if (emailController.text.isEmpty || emailController.text == ''){
                   EasyLoading.showError("email is required");
                 } else  if (passwordController.text.isEmpty || passwordController.text == ''){
                   EasyLoading.showError("Password is required");
                 }
                 else {
                   await AuthServices.signUP(
                       context: context,
                       userName: userNameController.text,
                       email: emailController.text,
                       password: passwordController.text);
                 }
                },
                title: "Sign Up",
              ),
              const SizedBox(height: 20),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  navigateWithPush(
                      context: context, pageName: const LoginScreen());
                },
                child: const Center(
                  child: Text(
                    "Already Have an Account? Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
