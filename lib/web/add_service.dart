import 'package:bangkit/models/service_category.dart';
import 'package:flutter/material.dart';
import '../profile/profileregistration.dart';

class AddService extends StatelessWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        NgoService.addService(name: nameController.text).then((value) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(value.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          nameController.text = '';
                        },
                        child: const Text("OK"))
                  ],
                );
              });
        });
      }),
      body: Column(
        children: [
          Center(
              child: CustomTextFormfieldRed(
            controller: nameController,
            labelText: "Add Ngo Service",
          )),
        ],
      ),
    );
  }
}
