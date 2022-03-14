import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/ngo.dart';
import 'package:bangkit/web/formcontrollers.dart/ngo_formcontroller.dart';
import 'package:bangkit/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NGOForm extends StatefulWidget {
  const NGOForm({Key? key, this.ngo}) : super(key: key);

  final Ngo? ngo;

  @override
  State<NGOForm> createState() => _NGOFormState();
}

class _NGOFormState extends State<NGOForm> {
  @override
  void initState() {
    super.initState();
    if (widget.ngo != null) {
      controller = NGOFormController.fromNgo(widget.ngo!);
    } else {
      controller = NGOFormController.plainNgo();
    }
  }

  ImageProvider getAvatar() {
    if (controller.image != null) {
      return NetworkImage(controller.image!);
    } else if (controller.fileData != null) {
      return MemoryImage(controller.fileData!);
    } else {
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
                      setState(() {});
                    });
                  },
                  child: CircleAvatar(
                    backgroundImage: getAvatar(),
                    radius: getWidth(context) * 0.08,
                  ),
                )
              ],
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: Scaffold(
            appBar: getAppBar(context),
            floatingActionButton: ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  if (controller.object != null) {
                    var future = controller.add();
                    showFutureDialog(context: context, future: future);
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
                      child: Text("NGO Details", style: TextStyle(fontSize: 40)),
                    ),
                    Wrap(
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.start,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
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
                          controller: TextEditingController(text: controller.image),
                          labelText: 'Image Url',
                        ),
                        CustomTextFormField(
                          controller: controller.urlSocialMedia,
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
                                  controller.state = value ?? controller.state;
                                  controller.postCode = postalCodes[controller.state]!.first['postCode'];
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
                                  controller.postCode = value ?? controller.postCode;
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
                                controller.service = value ?? controller.service;
                              },
                            ),
                          ),
                        ),
                      ],
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
