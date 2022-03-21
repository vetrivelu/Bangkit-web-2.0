import 'package:bangkit/models/rebuild.dart';
import 'package:bangkit/profile/profileregistration.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:get/get.dart';

import 'package:flutter/material.dart';

class Addrebuild extends StatefulWidget {
  Addrebuild({Key? key}) : super(key: key);

  @override
  State<Addrebuild> createState() => _AddrebuildState();
}

class _AddrebuildState extends State<Addrebuild> {
  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final postCodeController = TextEditingController();

  final stateController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final contactPersonController = TextEditingController();

  final emailController = TextEditingController();

  final descriptioncontroller = TextEditingController();

  final typeController = TextEditingController();

  final entityTypeController = TextEditingController();

  final imageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              var rebuild = Rebuild(
                name: nameController.text,
                address: addressController.text,
                image: imageController.text,
                postCode: postCodeController.text,
                state: stateController.text,
                phoneNumber: phoneNumberController.text,
                email: emailController.text,
                contactPersonName: contactPersonController.text,
                description: descriptioncontroller.text,
                // type: type ?? Type.medical,
              );
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                Rebuild.addrebuild(rebuild).then((value) => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Successfully Saved"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Okay"),
                          )
                        ],
                      );
                    }));
              }
            },
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Add rebuild",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomTextFormfieldRed(
                    labelText: 'name',
                    controller: nameController,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'Contact Person Name',
                    controller: contactPersonController,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'address',
                    controller: addressController,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'image url',
                    controller: imageController,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    keyboardType: TextInputType.number,
                    labelText: 'phoneNumber',
                    controller: phoneNumberController,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'email',
                    controller: emailController,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                      if (!emailController.text.isEmail) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'Post Code',
                    controller: postCodeController,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'State',
                    controller: stateController,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'description',
                    controller: descriptioncontroller,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
