import 'dart:ui';

import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key, this.email}) : super(key: key);
  final String? email;

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  void initState() {
    if (widget.email != null) {
      emailController.text = widget.email!;
    }
    super.initState();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(image: DecorationImage(image: AssetImage('assets/WhatsApp Image 2022-01-04 at 1.43.34 PM.jpeg'), fit: BoxFit.fill)),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Sign up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                CustomTextBox(controller: emailController, labelText: "Email", hintText: "Enter email"),
                CustomTextBox(controller: passwordController, labelText: "Password", hintText: "Enter password"),
                CustomTextBox(controller: confirmPasswordController, labelText: "Confirm Password", hintText: "Re-Enter password"),
                ElevatedButton(
                    onPressed: () async {
                      String title = '', message = '';
                      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                        title = "Empty Email or Password";
                        message = "Please fill-out both email and password";
                      } else if (!emailController.text.isEmail) {
                        title = "Invalid Email";
                        message = "Please enter a valid email";
                      } else {
                        await authController.auth.createUserWithEmailAndPassword(emailController.text, passwordController.text).then((value) {
                          title = "Success";
                          message = "Please log in to continue";
                          if (value != null) {
                            value.sendEmailVerification();
                          }
                          Navigator.of(context).popAndPushNamed('/sign-in');
                        }).catchError((error) {
                          title = error.code ?? "Error";
                          message = error.message ?? "Unknown Error";
                        });
                      }

                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(title),
                              content: Text(message),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Okay")),
                              ],
                            );
                          });
                    },
                    child: const Text("Submit")),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
