import 'package:bangkit/constants/constituency_list.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/profile.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class VolunteerList extends StatefulWidget {
  VolunteerList({Key? key}) : super(key: key);

  @override
  State<VolunteerList> createState() => _VolunteerListState();
}

class _VolunteerListState extends State<VolunteerList> {
  @override
  void initState() {
    super.initState();
    query = users.where("isVolunteer", isEqualTo: true);
  }

  List<String> selectedStates = [];

  late Query query;
  void _showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          title: const Text("Select State"),
          items: federals.keys.map((e) => MultiSelectItem(e.toString(), e.toString())).toList(),
          initialValue: selectedStates,
          onConfirm: (values) async {
            selectedStates = values.map((e) => e.toString()).toList();
            setState(() {
              query = query.where("primaryAddress.state", whereIn: selectedStates);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'VOLUNTEERS LIST',
                      style: TextStyle(
                        shadows: [Shadow(color: Colors.black, offset: Offset(0, -5))],
                        color: Colors.transparent,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        decorationThickness: 4,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showMultiSelect(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.filter_alt_sharp,
                    color: Color(0xFF22A8E0),
                  ),
                ),
              )
            ]),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: query.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.active) {
                print(streamSnapshot.data!.docs.length);
                if (streamSnapshot.hasError) {
                  return const Text("Error");
                }
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: const [
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Loading"),
                      )
                    ],
                  );
                }
                return Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: streamSnapshot.data!.docs.map((snapshot) {
                      var data = snapshot.data()! as Map<String, dynamic>;
                      var profile = Profile.fromJson(data);
                      print(data);
                      return CustomExpansionTile(profile: profile);
                      // print("I am data $data");
                    }).toList(),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  getFederals() {
    var returns = [];
    if (selectedStates.isEmpty) {
      for (var element in federals.keys) {
        returns.addAll(federals[element]!.keys.toList());
      }
    } else {
      for (var element in selectedStates) {
        returns.addAll(federals[element]!.keys.toList());
      }
    }
    return returns.map((e) => MultiSelectItem(e.toString(), e)).toList();
  }
}

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({Key? key, required this.profile}) : super(key: key);
  final Profile profile;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool showSubtitle = true;

  @override
  Widget build(BuildContext context) {
    // profile.update();
    return Card(
      child: ExpansionTile(
        onExpansionChanged: (bool value) {
          setState(() {
            showSubtitle = !showSubtitle;
          });
        },
        trailing: SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.profile.isApproved
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            widget.profile.isApproved = true;
                            widget.profile.updateUser();
                          },
                          child: const Text("Approve")),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PhotoViewGallery.builder(
                              itemCount: widget.profile.documents.length,
                              builder: (context, index) {
                                return PhotoViewGalleryPageOptions(
                                  imageProvider: NetworkImage(widget.profile.documents[index]),
                                  initialScale: PhotoViewComputedScale.contained * 0.8,
                                  heroAttributes: PhotoViewHeroAttributes(tag: widget.profile.documents[index]),
                                );
                              },
                            );
                          });
                    },
                    child: const Text("See Attachments")),
              ),
            ],
          ),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: showSubtitle ? 4 : 32),
          child: Text(
            widget.profile.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: showSubtitle
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  widget.profile.about.toString(),
                  maxLines: 2,
                  softWrap: true,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
              )
            : null,
        iconColor: Colors.red,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.profile.about.toString(),
              maxLines: 20,
              softWrap: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.location_on, color: Colors.red),
              ),
              Flexible(
                child: Text(
                  "${widget.profile.primaryAddress.fullAddress}",
                  maxLines: 3,
                  softWrap: true,
                  style: const TextStyle(overflow: TextOverflow.clip),
                ),
              )
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.location_on, color: Colors.red),
              ),
              Flexible(
                child: Text(
                  "${widget.profile.secondaryAddress.fullAddress}",
                  maxLines: 3,
                  softWrap: true,
                  style: const TextStyle(overflow: TextOverflow.clip),
                ),
              )
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.person_rounded, color: Colors.red),
              ),
              Text(widget.profile.name)
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          Table(
            children: [
              TableRow(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.phone, color: Colors.red),
                      ),
                      Text(widget.profile.phone)
                    ],
                    mainAxisSize: MainAxisSize.max,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.phone, color: Colors.red),
                      ),
                      Text(widget.profile.secondaryPhone)
                    ],
                    mainAxisSize: MainAxisSize.max,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.mail, color: Colors.red),
              ),
              Text(widget.profile.email)
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.facebook, color: Colors.red),
              ),
              Text(widget.profile.phone)
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
