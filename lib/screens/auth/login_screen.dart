import 'package:everyhosta/screens/auth/forgot_password_screen.dart';
import 'package:everyhosta/screens/auth/sign_up_screen.dart';
import 'package:everyhosta/utils/navigations.dart';
import 'package:everyhosta/widgets/custom_text_input.dart';
import 'package:everyhosta/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
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
              const SizedBox(height: 150),
              const Text(
                "Every Hosta",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
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
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  navigateWithPush(
                      context: context, pageName: const ForgotPasswordScreen());
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      emailController.text == '') {
                    EasyLoading.showError("email is required");
                  } else if (passwordController.text.isEmpty ||
                      passwordController.text == '') {
                    EasyLoading.showError("Password is required");
                  } else {
                    await AuthServices.login(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text);
                  }
                },
                title: "Login",
              ),
              const SizedBox(height: 20),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()));
                },
                child: const Center(
                  child: Text(
                    "Don't Have an Account? SignUp",
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
