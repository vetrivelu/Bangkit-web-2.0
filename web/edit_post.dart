import 'package:bangkit/models/aid_and_grant.dart';
import 'package:bangkit/profile/profileregistration.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  EditPost({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  @override
  void initState() {
    // TODO: implement initState
    title.text = widget.post.title;
    description.text = widget.post.description;
    if (widget.post.media != null) {
      switch (widget.post.media!.length) {
        case 1:
          media1.text = widget.post.media![0];
          break;
        case 2:
          media1.text = widget.post.media![0];
          media2.text = widget.post.media![1];
          break;
        case 3:
          media1.text = widget.post.media![0];
          media2.text = widget.post.media![1];
          media3.text = widget.post.media![2];
          break;
      }
    }

    if (widget.post.attachments != null) {
      switch (widget.post.attachments!.length) {
        case 1:
          attachment1.text = widget.post.attachments![0];
          break;
        case 2:
          attachment1.text = widget.post.attachments![0];
          attachment2.text = widget.post.attachments![1];
          break;
        case 3:
          attachment1.text = widget.post.attachments![0];
          attachment2.text = widget.post.attachments![1];
          attachment3.text = widget.post.attachments![2];
          break;
      }
    }

    if (widget.post.videos != null) {
      switch (widget.post.videos!.length) {
        case 1:
          video1.text = widget.post.videos![0];
          break;
        case 2:
          video1.text = widget.post.videos![0];
          video2.text = widget.post.videos![1];
          break;
        case 3:
          video1.text = widget.post.videos![0];
          video2.text = widget.post.videos![1];
          video3.text = widget.post.videos![2];
          break;
      }
    }

    address.text = widget.post.address;
    state.text = widget.post.state;
    pincode.text = widget.post.pincode;
    name.text = widget.post.name;
    phone.text = widget.post.phone;
    email.text = widget.post.email;
    super.initState();
  }

  final title = TextEditingController();
  final description = TextEditingController();
  final media1 = TextEditingController();
  final media2 = TextEditingController();
  final media3 = TextEditingController();
  final attachment1 = TextEditingController();
  final attachment2 = TextEditingController();
  final attachment3 = TextEditingController();
  final video1 = TextEditingController();
  final video2 = TextEditingController();
  final video3 = TextEditingController();
  final address = TextEditingController();
  final state = TextEditingController();
  final pincode = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();

  Post buildPost() {
    List<String> media = [];
    List<String> attachment = [];
    List<String> video = [];
    if (media1.text.isNotEmpty) {
      media.add(media1.text);
    }
    if (media2.text.isNotEmpty) {
      media.add(media2.text);
    }
    if (media3.text.isNotEmpty) {
      media.add(media3.text);
    }

    if (attachment1.text.isNotEmpty) {
      attachment.add(attachment1.text);
    }
    if (attachment2.text.isNotEmpty) {
      attachment.add(attachment2.text);
    }
    if (attachment3.text.isNotEmpty) {
      attachment.add(attachment3.text);
    }
    if (video1.text.isNotEmpty) {
      video.add(video1.text);
    }
    if (video2.text.isNotEmpty) {
      video.add(video2.text);
    }
    if (video3.text.isNotEmpty) {
      video.add(video3.text);
    }

    return Post(
      title: title.text,
      description: description.text,
      name: name.text,
      address: address.text,
      state: state.text,
      pincode: pincode.text,
      phone: phone.text,
      email: email.text,
      videos: video,
      attachments: attachment,
      media: media,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var result = _formKey.currentState?.validate() ?? false;
          print(_formKey.currentState?.validate());
          if (result) {
            _formKey.currentState?.save();
            Post post = buildPost();
            post.id = widget.post.id;
            post.update().then((value) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(value.message.toString()),
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
                    return null;
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
                    return null;
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
                    return null;
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
                    return null;
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
                    return null;
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
                    return null;
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
                    return null;
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
                    return null;
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
                CustomTextFormfieldRed(
                  controller: video1,
                  labelText: "videoUrl",
                ),
                CustomTextFormfieldRed(
                  controller: video2,
                  labelText: "videoUrl",
                ),
                CustomTextFormfieldRed(
                  controller: video3,
                  labelText: "videoUrl",
                ),
              ],
            )),
      ),
    );
  }
}
