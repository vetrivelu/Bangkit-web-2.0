import 'package:bangkit/models/response.dart';
import 'package:flutter/material.dart';

import '../constants/postal_codes.dart';
import '../constants/themeconstants.dart';
import '../models/adun.dart';
import '../widgets/widgets.dart';
import 'formcontrollers.dart/adun_formController.dart';

enum Provide { network, memory, logo }

class AdunForm extends StatefulWidget {
  AdunForm({Key? key, this.adun}) : super(key: key);

  final Adun? adun;

  @override
  State<AdunForm> createState() => _AdunFormState();
}

class _AdunFormState extends State<AdunForm> {
  var future;
  late AdunFormController controller;
  Provide show = Provide.logo;

  @override
  void initState() {
    if (widget.adun == null) {
      controller = AdunFormController();
      controller.setState = PostalCodes.data.keys.first;
    } else {
      controller = AdunFormController.fromAdun(widget.adun!);
      if ((controller.image ?? '').isNotEmpty) {
        show = Provide.network;
      }
    }
    super.initState();
  }

  String? requiredValidator(String? val) {
    var text = val ?? '';
    if (text.isEmpty) {
      return "This is a required field";
    }
    return null;
  }

  ImageProvider getAvatar() {
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

  Adun? get adun => widget.adun;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
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
        ),
        Expanded(
          flex: 8,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        controller.name.text = "Vetri";
                        controller.address.text = "225, North Street";
                        controller.phoneNumber.text = "+61898709";
                        controller.email.text = "test@testemail.com";
                        controller.weburl.text = "www.google.com";
                        controller.description.text = "Test Description";
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
                  if (widget.adun != null) {
                    future = controller.update();
                  } else {
                    future = controller.add();
                  }
                  showFutureCustomDialog(
                      context: context, future: future, onTapOk: () {});
                }
              },
              child: const Text("Submit"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    color: const Color(0xffCAE5F5),
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formkey,
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.start,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text("ADUN Details",
                                    style: TextStyle(fontSize: 40)),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(),
                            ),
                            CustomTextFormField(
                              controller: controller.name,
                              labelText: 'Name',
                              validator: requiredValidator,
                            ),
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
                              controller: controller.address,
                              labelText: 'Address',
                              validator: requiredValidator,
                            ),
                            CustomTextFormField(
                              controller: controller.weburl,
                              labelText: 'Web / Social Media Reference',
                              validator: requiredValidator,
                            ),
                            CustomTextFormField(
                              controller: controller.imageUrl,
                              labelText: 'Image URL',
                              onChanged: (text) {
                                controller.image = text;
                              },
                              // validator: requiredValidator,
                            ),
                            CustomTextFormField(
                              controller: controller.description,
                              labelText: 'Description',
                              validator: requiredValidator,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(),
                            ),
                            SizedBox(
                              width: getWidth(context) / 4,
                              child: ListTile(
                                title: const Text("State"),
                                subtitle: DropdownButtonFormField<String>(
                                  value: controller.state,
                                  items: controller.stateItems,
                                  onChanged: (String? value) {
                                    setState(() {
                                      controller.setState =
                                          value ?? controller.firstState;
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
                                title: const Text("Federal Constituency"),
                                subtitle: DropdownButtonFormField<String>(
                                  items: controller.federalItems,
                                  value: controller.federal,
                                  onChanged: (String? value) {
                                    setState(() {
                                      controller.federal =
                                          value ?? controller.federal;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: double.maxFinite),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
