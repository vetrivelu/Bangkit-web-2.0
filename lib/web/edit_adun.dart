import 'dart:ui';

import 'package:bangkit/constants/constituency_list.dart';
import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/models/adun.dart';
import 'package:bangkit/profile/profileregistration.dart';
import 'package:bangkit/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:bangkit/models/ngo.dart';
import '../profile/profileregistration.dart';

import 'package:get/get.dart';

class EditAdun extends StatefulWidget {
  const EditAdun({Key? key, required this.adun}) : super(key: key);

  final Adun adun;

  @override
  State<EditAdun> createState() => _EditAdunState();
}

class _EditAdunState extends State<EditAdun> {
  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final postCodeController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final emailController = TextEditingController();

  final descriptioncontroller = TextEditingController();
  final imageController = TextEditingController();
  final stateController = TextEditingController();
  final weburlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.adun.name;

    addressController.text = widget.adun.officeAddress;

    postCodeController.text = widget.adun.postCode;

    phoneNumberController.text = widget.adun.contactNumber;

    emailController.text = widget.adun.emailAddress;

    descriptioncontroller.text = widget.adun.description;
    imageController.text = widget.adun.image;
    stateController.text = widget.adun.state;
    weburlController.text = widget.adun.weburl;

    selectedState = widget.adun.state;
    federalList = federals[selectedState]!.keys.toList();
    selectedFederal = widget.adun.federal;
  }

  var selectedState;

  var selectedFederal;

  List<String> federalList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () {
              var adun = Adun(
                state: selectedState,
                name: nameController.text,
                contactNumber: phoneNumberController.text,
                description: descriptioncontroller.text,
                emailAddress: emailController.text,
                officeAddress: addressController.text,
                postCode: postCodeController.text,
                image: imageController.text,
                weburl: weburlController.text,
                federal: selectedFederal,
              );
              adun.id = widget.adun.id;
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                adun.update().then((value) => showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text("Successfully updated"),
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
                      "Add ADUN",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'phoneNumber',
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'image url',
                    controller: imageController,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
                      if (!emailController.text.isEmail) {
                        return "Enter a vaild email";
                      }
                    },
                  ),
                  CustomTextFormfieldRed(
                    labelText: 'Web / SocialMedia Reference',
                    controller: weburlController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
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
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomDropDownButtonformField(
                    labelText: "State",
                    value: selectedState,
                    onChanged: (value) {
                      setState(() {
                        selectedState = value ?? selectedState;
                        federalList = federals[selectedState]!.keys.toList();
                        selectedFederal = federalList.first;
                      });
                    },
                    item: federals.keys.map((e) => DropdownMenuItem(child: Text(e.toString()), value: e.toString())).toList(),
                  ),
                  CustomDropDownButtonformField(
                    labelText: "Federal constituency",
                    value: selectedFederal,
                    onChanged: (value) {
                      setState(() {
                        selectedFederal = value ?? selectedFederal;
                      });
                    },
                    item: federalList.map((e) => DropdownMenuItem(value: e.toString(), child: Text(e.toString()))).toList(),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )),
    );
  }

  getFederals() {
    return federals[selectedState]!
        .keys
        .map((e) => DropdownMenuItem(
              child: Text(e.toString()),
              value: e.toString(),
            ))
        .toList();
  }
}
