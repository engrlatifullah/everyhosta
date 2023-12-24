import 'package:everyhosta/services/auth_services.dart';
import 'package:everyhosta/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.4),
              const Center(
                child: Text(
                  "Every Hosta",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomTextInput(
                controller: emailController,
                title: "E-Mail",
                icon: Icons.email,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      emailController.text == '') {
                    EasyLoading.showError("email is required");
                  } else {
                    await AuthServices.forgotPassword(
                        email: emailController.text);
                  }
                },
                title: "Submit",
              )
            ],
          ),
        ),
      ),
    );
  }
}
