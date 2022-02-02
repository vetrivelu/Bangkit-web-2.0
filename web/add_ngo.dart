import 'dart:async';
import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/models/ngo.dart';
import 'package:bangkit/profile/profileregistration.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddNgo extends StatefulWidget {
  AddNgo({Key? key}) : super(key: key);

  @override
  State<AddNgo> createState() => _AddNgoState();
}

class _AddNgoState extends State<AddNgo> {
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

  final urlControlller = TextEditingController();

  final imageController = TextEditingController();

  final websiteController = TextEditingController();

  EntityType? entity = EntityType.government;
  // var type;
  ServiceType? serviceType = ServiceType.assistance;

  late String selectedService;
  String selectedState = postalCodes.keys.first;

  List<String> services = [];
  // late  List<Paths?> _paths = [];
  late List<String?> items = [null];
  late List<Widget> _storeItmes = [];
  String _path = '';
  File? _file = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    entity = EntityType.government;
    serviceType = ServiceType.assistance;
    services = serviceListController.service ?? [];
    selectedService = services.first;
  }

  Future chooseFile() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _path = file.path;
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: FloatingActionButton(
              //       child: const Icon(Icons.file_upload_outlined),
              //       onPressed: () async {
              //         await chooseFile();
              //         await uploadFile(File(_path)).then((value) {
              //           showDialog(
              //               context: context,
              //               builder: (context) {
              //                 return AlertDialog(
              //                   title: Text(value),
              //                 );
              //               });
              //         }).catchError((error) {
              //           showDialog(
              //               context: context,
              //               builder: (context) {
              //                 return AlertDialog(
              //                   title: Text(error.toString()),
              //                 );
              //               });
              //         });
              //         imageController.text = _path;
              //       }),
              // ),
              FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  var ngo = Ngo(
                    name: nameController.text,
                    address: addressController.text,
                    image: imageController.text,
                    postCode: postCodeController.text,
                    state: selectedState,
                    phoneNumber: phoneNumberController.text,
                    email: emailController.text,
                    contactPersonName: contactPersonController.text,
                    description: descriptioncontroller.text,
                    service: selectedService,
                    entityType: EntityType.private,
                    serviceType: serviceType,
                    urlWeb: urlControlller.text,
                    urlSocialMedia: '',
                  );
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    Ngo.addNgo(ngo).then((value) => showDialog(
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
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Add NGO",
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
                    labelText: 'Contact Person Name',
                    controller: contactPersonController,
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
                    labelText: 'image url',
                    controller: imageController,
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return "This is a required field";
                      }
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
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormfieldRed(
                    labelText: 'Social Media/ Website reference',
                    controller: urlControlller,
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
                  CustomDropDownButtonformField(
                    labelText: "State",
                    value: selectedState,
                    onChanged: (value) {
                      setState(() {
                        selectedState = value ?? selectedState;
                      });
                    },
                    item: postalCodes.keys
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                  ),
                  CustomDropDownButtonformField(
                    labelText: "Service",
                    value: selectedService,
                    onChanged: (value) {
                      setState(() {
                        selectedService = value ?? selectedService;
                      });
                    },
                    item: services.map((e) => DropdownMenuItem(value: e, child: Text(e.toString()))).toList(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
