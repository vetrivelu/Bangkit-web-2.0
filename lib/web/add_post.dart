import 'package:bangkit/models/aid_and_grant.dart';
import 'package:bangkit/profile/profileregistration.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final title = TextEditingController();
  final description = TextEditingController();
  final media1 = TextEditingController();
  final media2 = TextEditingController();
  final media3 = TextEditingController();
  final attachment1 = TextEditingController();
  final attachment2 = TextEditingController();
  final attachment3 = TextEditingController();
  final address = TextEditingController();
  final state = TextEditingController();
  final pincode = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();

  Post buildPost() {
    return Post(
      title: title.text,
      description: description.text,
      name: name.text,
      address: address.text,
      state: state.text,
      pincode: pincode.text,
      phone: phone.text,
      email: email.text,
      attachments: [attachment1.text, attachment2.text, attachment3.text],
      media: [media1.text, media2.text, media3.text],
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          print("I am here");
          var result = _formKey.currentState?.validate() ?? false;
          print(_formKey.currentState?.validate());
          if (result) {
            print(" I passed");
            _formKey.currentState?.save();
            Post post = buildPost();
            Post.addPost(post).then((value) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(value["message"].toString()),
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
                CustomTextFormfieldRed(
                  controller: title,
                  labelText: "title",
                ),
                CustomTextFormfieldRed(
                  controller: description,
                  labelText: "description",
                  validator: (value) {
                    value = value ?? '';
                    if (value.isEmpty) {
                      return "This is a required field";
                    }
                  },
                ),
                CustomTextFormfieldRed(
                  controller: name,
                  labelText: "name",
                  validator: (value) {
                    value = value ?? '';
                    if (value.isEmpty) {
                      return "This is a required field";
                    }
                  },
                ),
                CustomTextFormfieldRed(
                  controller: address,
                  labelText: "address",
                  validator: (value) {
                    value = value ?? '';
                    if (value.isEmpty) {
                      return "This is a required field";
                    }
                  },
                ),
                CustomTextFormfieldRed(
                  controller: phone,
                  labelText: "phone",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    value = value ?? '';
                    if (value.isEmpty) {
                      return "This is a required field";
                    }
                  },
                ),
                CustomTextFormfieldRed(
                  controller: email,
                  labelText: "email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    value = value ?? '';
                    if (value.isEmpty) {
                      return "This is a required field";
                    }
                  },
                ),
                CustomTextFormfieldRed(
                  controller: state,
                  labelText: "state",
                  validator: (value) {
                    value = value ?? '';
                    if (value.isEmpty) {
                      return "This is a required field";
                    }
                  },
                ),
                CustomTextFormfieldRed(
                  controller: pincode,
                  labelText: "pincode",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    value = value ?? '';
                    if (value.isEmpty) {
                      return "This is a required field";
                    }
                  },
                ),
                CustomTextFormfieldRed(
                  controller: media1,
                  labelText: "imageUrl",
                  validator: (value) {
                    value = value ?? '';
                    if (value.isEmpty) {
                      return "This is a required field";
                    }
                  },
                ),
                CustomTextFormfieldRed(
                  controller: media2,
                  labelText: "imageUrl",
                ),
                CustomTextFormfieldRed(
                  controller: media3,
                  labelText: "imageUrl",
                ),
                CustomTextFormfieldRed(
                  controller: attachment1,
                  labelText: "attachmentUrl",
                ),
                CustomTextFormfieldRed(
                  controller: attachment2,
                  labelText: "attachmentUrl",
                ),
                CustomTextFormfieldRed(
                  controller: attachment3,
                  labelText: "attachmentUrl",
                ),
              ],
            )),
      ),
    );
  }
}
