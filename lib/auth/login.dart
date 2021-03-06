import 'dart:ui';

import 'package:bangkit/auth/forgot_password.dart';
import 'package:bangkit/auth/signup.dart';
import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/widgets/widgets.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AuthProvider authType = AuthProvider.email;
  bool obscureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,

      // backgroundColor: Colors.redAccent.withOpacity(0.9),
      body: Stack(
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Image.asset(
                'assets/background.jpg',
                fit: BoxFit.cover,
              )),
          ClipRect(
            child: BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Card(
                color: Colors.white.withOpacity(0.5),
                elevation: 30,
                child: SizedBox(
                  height: getHeight(context),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: 600,
                          child: SingleChildScrollView(
                            child: SizedBox(
                              width: double.maxFinite * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: getHeight(context) / 4,
                                      child: Image.asset(
                                        'assets/bina.png',
                                        fit: BoxFit.contain,
                                        scale: 0.1,
                                      ),
                                    ),
                                    CustomTextFormField(
                                      hintText: 'Enter your email',
                                      labelText: 'Email',
                                      controller: emailController,
                                    ),
                                    CustomTextFormField(
                                      controller: passwordController,
                                      hintText: 'Enter your password',
                                      labelText: 'Password',
                                      obscureText: obscureText,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            obscureText = !obscureText;
                                          });
                                        },
                                        child: obscureText
                                            ? const Icon(
                                                Icons.visibility_off_outlined,
                                                color: Colors.black,
                                                size: 22,
                                              )
                                            : const Icon(
                                                Icons.visibility_outlined,
                                                color: Colors.black,
                                                size: 22,
                                              ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                      child: SizedBox(
                                        width: getWidth(context) / 9,
                                        height: getHeight(context) * 0.05,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              elevation: MaterialStateProperty.all(10),
                                              shadowColor: MaterialStateProperty.all(Colors.redAccent),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                              )),
                                            ),
                                            onPressed: () async {
                                              String title = '', message = '';
                                              if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                                                title = "Empty Email or Password";
                                                message = "Please fill-out both email and password";
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
                                              } else if (!emailController.text.isEmail) {
                                                title = "Invalid Email";
                                                message = "Please enter a valid email";
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
                                              } else {
                                                await authController.auth
                                                    .signInWithEmailAndPassword(emailController.text, passwordController.text)
                                                    .then((value) {
                                                  Navigator.of(context).popAndPushNamed('/');
                                                }).catchError((error) {
                                                  title = error.code ?? "Error";
                                                  message = error.message ?? "Unknown Error";
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
                                                });
                                              }
                                            },
                                            child: const Text('Login')),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    TextButton(
                                      onPressed: () {
                                        // ignore: avoid_print
                                        print("Pressed");
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return ForgotPassword(
                                                email: emailController.text,
                                              );
                                            });
                                      },
                                      child: const Text(
                                        'Forgot Password ?',
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Expanded(flex: 1, child: Container(color: const Color(0xFF63e5ff))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
