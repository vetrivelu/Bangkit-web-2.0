import 'package:bangkit/constants/postal_codes.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:bangkit/web/formcontrollers.dart/post_formcontroller.dart';
import 'package:bangkit/widgets/imagewidget.dart' as image;
import 'package:bangkit/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../models/aid_and_grant.dart';

class PostForm extends StatefulWidget {
  PostForm({Key? key, this.post}) : super(key: key);
  final Post? post;
  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      controller = PostFormController.fromPost(widget.post!);
      posts.doc(widget.post!.id.toString()).snapshots().listen((snapshot) {
        Post tempPost = Post.fromJson(snapshot.data()!);
        setState(() {
          widget.post!.media = tempPost.media;
          widget.post!.attachments = tempPost.attachments;
        });
      });
    }
  }

  PostFormController controller = PostFormController();

  List<Widget> getImages() {
    List<Widget> images = [];

    if ((controller.imageData ?? []).isNotEmpty) {
      for (int i = 0; i < (controller.imageData?.length ?? 0); i++) {
        images.add(image.FileImage(
          image: controller.imageData![i],
          onTap: () {
            controller.imageData!.removeAt(i);
            setState(() {});
          },
        ));
      }
    }

    images.add(image.NullImage(
      onTap: () {
        controller.imagePicker().then((value) {
          setState(() {});
        });
      },
    ));

    return images;
  }

  List<Widget> getFiles() {
    List<Widget> images = [];

    if (controller.platformFiles.isNotEmpty) {
      for (var element in controller.platformFiles) {
        images.add(
          image.FileWidget(
              name: element.name,
              onTap: () {
                controller.platformFiles
                    .removeWhere((file) => file.name == element.name);
                setState(() {});
              }),
        );
      }
    }

    images.add(
      image.NullImage(
        icon: const Icon(Icons.addchart),
        onTap: () {
          controller.filePicker().then((value) {
            setState(() {});
          });
        },
      ),
    );
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: const Color.fromARGB(255, 185, 230, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      CustomTextFormField(
                        controller:
                            TextEditingController(text: controller.title),
                        onChanged: (p0) => controller.title = p0,
                        labelText: 'Title',
                        hintText: 'Enter title',
                      ),
                      SizedBox(
                        width: getWidth(context),
                      ),
                      ListTile(
                        title: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Description'),
                        ),
                        subtitle: SizedBox(
                          height: 260,
                          width: 240,
                          child: TextField(
                            controller: TextEditingController(
                                text: controller.description),
                            maxLines: 10,
                            onChanged: (p0) => controller.description = p0,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 203, 220, 233),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Card(
                color: const Color.fromARGB(255, 185, 230, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: getWidth(context),
                      ),
                      CustomTextFormField(
                        controller:
                            TextEditingController(text: controller.name),
                        onChanged: (p0) => controller.name = p0,
                        labelText: 'Name',
                      ),
                      CustomTextFormField(
                        controller:
                            TextEditingController(text: controller.phone),
                        onChanged: (p0) => controller.phone = p0,
                        labelText: 'Phone',
                      ),
                      CustomTextFormField(
                        controller:
                            TextEditingController(text: controller.email),
                        onChanged: (p0) => controller.email = p0,
                        labelText: 'Email',
                      ),
                      CustomTextFormField(
                        controller:
                            TextEditingController(text: controller.address),
                        onChanged: (p0) => controller.address = p0,
                        labelText: 'Address',
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
                                controller.state = value;
                                controller.pincode = PostalCodes
                                    .data[controller.state]?.first
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
                            value: controller.pincode,
                            items: controller.postalCodeItems,
                            onChanged: (String? value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Card(
                color: const Color.fromARGB(255, 185, 230, 252),
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextFormField(
                                  controller: TextEditingController(
                                      text: controller.videos[0]),
                                  labelText: 'Video URL',
                                  onChanged: (p0) => controller.videos[0] = p0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: getWidth(context) * 0.05,
                          width: 5,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Wrap(
                            children: getImages(),
                          ),
                        ),
                        Container(
                          height: getWidth(context) * 0.05,
                          width: 4,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Wrap(
                            children: getFiles(),
                          ),
                        ),
                      ],
                    ),

                    // SizedBox(width: getWidth(context)),

                    const Divider(),
                    SizedBox(width: getWidth(context)),
                  ],
                ),
              ),
              widget.post == null
                  ? Container()
                  : Card(
                      child: Wrap(
                        children: [
                          Row(
                              children: widget.post?.media
                                      ?.map((e) => image.NetworkImage(
                                            url: e,
                                            onTap: () {
                                              controller.removeImage(e);
                                            },
                                          ))
                                      .toList() ??
                                  [])
                        ],
                      ),
                    ),
              widget.post == null
                  ? Container()
                  : Card(
                      child: Wrap(
                        children: [
                          Row(
                              children: widget.post?.attachments
                                      ?.map((e) => image.FileWidget(
                                            name: e,
                                            onTap: () {
                                              try {
                                                controller.removeAttachement(e);
                                              } catch (e) {}
                                            },
                                          ))
                                      .toList() ??
                                  [])
                        ],
                      ),
                    ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        var future;
                        if (widget.post == null) {
                          future = Post.addPost(controller.post);
                        } else {
                          future = controller.update();
                        }
                        showFutureCustomDialog(
                            context: context,
                            future: future,
                            onTapOk: () {
                              setState(() {
                                controller.platformFiles = [];
                                controller.imageData = [];
                              });
                              Navigator.of(context).pop();
                            });
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                        child: Text("Submit"),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
