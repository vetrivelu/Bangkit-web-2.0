import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/constants/postal_codes.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/ngo.dart';
import 'package:bangkit/web/formcontrollers.dart/ngo_formcontroller.dart';
import 'package:bangkit/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NGOForm extends StatefulWidget {
  const NGOForm({Key? key, this.ngo, required this.entity}) : super(key: key);

  final Ngo? ngo;
  final EntityType entity;

  @override
  State<NGOForm> createState() => _NGOFormState();
}

class _NGOFormState extends State<NGOForm> {
  Provide show = Provide.logo;

  @override
  void initState() {
    super.initState();
    if (widget.ngo != null) {
      controller = NGOFormController.fromNgo(widget.ngo!);
      show = Provide.network;
    } else {
      controller = NGOFormController(type: widget.entity);
    }
  }

  ImageProvider getAvatar() {
    // if (controller.image != null) {
    //   return NetworkImage(controller.image!);
    // } else if (controller.fileData != null) {
    //   return MemoryImage(controller.fileData!);
    // } else {
    //   return const AssetImage('assets/bina.png');
    // }

    switch (show) {
      case Provide.network:
        return NetworkImage(controller.image!);

      case Provide.memory:
        return MemoryImage(controller.fileData!);

      case Provide.logo:
        return const AssetImage('assets/bina.png');

      default:
        return const AssetImage('assets/bina.png');
    }
  }

  String? requiredValidator(String? val) {
    var text = val ?? '';
    if (text.isEmpty) {
      return "This is a required field";
    }
    return null;
  }

  late NGOFormController controller;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.lightBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.imagePicker().then((value) {
                      setState(() {
                        show = Provide.memory;
                      });
                    });
                  },
                  child: CircleAvatar(
                    backgroundImage: getAvatar(),
                    radius: getWidth(context) * 0.08,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.imagePicker().then((value) {
                        setState(() {
                          show = Provide.memory;
                        });
                      });
                    },
                    child: const Text(
                      "Click to upload a new photo",
                      style: TextStyle(color: Color(0xff2FA8E0)),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                  ),
                )
              ],
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        controller.name.text = "Public Helpers";
                        controller.contactPersonName.text = "Vetri";
                        controller.address.text = "225, North Street";
                        controller.phoneNumber.text = "+61898709";
                        controller.email.text = "test@testemail.com";
                        controller.urlWeb.text = "www.google.com";
                        controller.description.text = "Test Description";
                        controller.urlSocialMedia.text = "www.google.com";
                      });
                    },
                    icon: const Icon(
                      Icons.upload,
                      color: Colors.blue,
                    ))
              ],
              title: SizedBox(
                  height: getHeight(context) * 0.15,
                  child: Image.asset('assets/bina.png')),
            ),
            floatingActionButton: ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  var future;
                  if (controller.object != null) {
                    if (controller.object?.id == null) {
                      future = controller.add();
                    } else {
                      future = controller.update();
                    }
                    try {
                      // future.then((value) => null);
                      showFutureCustomDialog(
                          context: context,
                          future: future,
                          onTapOk: () {
                            Navigator.of(context).pop();
                          });
                    } catch (e) {
                      print(e.toString());
                    }
                  } else {
                    print("==========================");
                  }
                } else {
                  print("Hle");
                }
              },
              child: const Text("Submit"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child:
                          Text("NGO Details", style: TextStyle(fontSize: 40)),
                    ),
                    Card(
                      color: const Color.fromARGB(255, 208, 228, 238),
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.start,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            const SizedBox(
                              width: double.maxFinite,
                              height: 60,
                            ),
                            CustomTextFormField(
                              controller: controller.name,
                              labelText: 'Name',
                              validator: requiredValidator,
                            ),
                            CustomTextFormField(
                              controller: controller.contactPersonName,
                              labelText: 'Contact Person Name',
                              validator: requiredValidator,
                            ),
                            CustomTextFormField(
                              controller: controller.address,
                              labelText: 'Address',
                              validator: requiredValidator,
                            ),
                            // DropdownButtonFormField<String>(items: items, onChanged: (String? value) {}),
                            CustomTextFormField(
                              controller: controller.phoneNumber,
                              labelText: 'Phone Number',
                              validator: requiredValidator,
                            ),
                            CustomTextFormField(
                              controller: controller.email,
                              labelText: 'Email',
                              validator: requiredValidator,
                            ),
                            CustomTextFormField(
                              controller: TextEditingController(
                                  text: controller.image ?? ''),
                              labelText: 'Image Url',
                              onChanged: (text) {
                                controller.image = text;
                              },
                            ),
                            CustomTextFormField(
                              controller: controller.urlWeb,
                              labelText: 'Web Reference',
                              validator: requiredValidator,
                            ),
                            CustomTextFormField(
                              controller: controller.description,
                              labelText: 'Description',
                              validator: requiredValidator,
                            ),

                            const SizedBox(width: double.maxFinite),
                            SizedBox(
                              width: getWidth(context) / 4,
                              child: ListTile(
                                title: const Text("State"),
                                subtitle: DropdownButtonFormField<String>(
                                  value: controller.state,
                                  items: controller.stateItems,
                                  onChanged: (String? value) {
                                    setState(() {
                                      controller.state =
                                          value ?? controller.state;
                                      controller.postCode =
                                          PostalCodes.getCodes(
                                                  controller.state!)
                                              .first
                                              .toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getWidth(context) / 4,
                              child: ListTile(
                                title: const Text("Postcode"),
                                subtitle: DropdownButtonFormField<String>(
                                  items: controller.postalCodeItems,
                                  value: controller.postCode,
                                  onChanged: (String? value) {
                                    setState(() {
                                      controller.postCode =
                                          value ?? controller.postCode;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getWidth(context) / 4,
                              child: ListTile(
                                title: const Text("Service"),
                                subtitle: DropdownButtonFormField<String>(
                                  value: controller.service,
                                  items: serviceListController.items,
                                  onChanged: (String? value) {
                                    controller.service =
                                        value ?? controller.service;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 120,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          flex: 8,
        ),
      ],
    );
  }
}

enum Provide { network, memory, logo }
