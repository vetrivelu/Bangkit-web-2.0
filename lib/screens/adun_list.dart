import 'package:bangkit/constants/constituency_list.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/adun.dart';
import 'package:bangkit/services/firebase.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../web/adun_form.dart';

class AdunList extends StatefulWidget {
  AdunList({Key? key}) : super(key: key);

  @override
  State<AdunList> createState() => _AdunListState();
}

class _AdunListState extends State<AdunList> {
  @override
  void initState() {
    super.initState();
    query = aduns;
  }

  List<String> selectedStates = [];
  List<String> selectedFederals = [];
  late Query query;
  void _showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          title: const Text("Select State"),
          items: federals.keys
              .map((e) => MultiSelectItem(e.toString(), e.toString()))
              .toList(),
          initialValue: selectedStates,
          onConfirm: (values) async {
            selectedStates = values.map((e) => e.toString()).toList();
            setState(() {
              query = aduns;
              query = query.where("state", whereIn: selectedStates);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AdunForm());
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'ADUN LIST',
                          style: TextStyle(
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, -5))
                            ],
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
          MultiSelectDialogField(
            buttonText: const Text("Select Constituency"),
            title: const Text("Select Constituency"),
            searchable: true,
            searchHint: "Select Constituency",
            items: getFederals(),
            onConfirm: (List<String?> values) {
              setState(() {
                selectedFederals = values.map((e) => e.toString()).toList();
              });
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: query.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.active) {
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
                // print(streamSnapshot.hasData);
                return Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: streamSnapshot.data!.docs.map((snapshot) {
                      var data = snapshot.data()! as Map<String, dynamic>;
                      var adun = Adun.fromJson(data);
                      if (selectedFederals.isNotEmpty) {
                        var result = selectedFederals.contains(adun.federal);
                        return result
                            ? CustomExpansionTile(ngo: adun)
                            : Container();
                      } else {
                        return CustomExpansionTile(ngo: adun);
                      }
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
      federals.keys.forEach((element) {
        returns.addAll(federals[element]!.keys.toList());
      });
    } else {
      selectedStates.forEach((element) {
        returns.addAll(federals[element]!.keys.toList());
      });
    }
    return returns.map((e) => MultiSelectItem(e.toString(), e)).toList();
  }
}

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({Key? key, required this.ngo}) : super(key: key);
  final Adun ngo;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool showSubtitle = true;

  @override
  Widget build(BuildContext context) {
    // ngo.update();
    return Card(
      child: ExpansionTile(
        onExpansionChanged: (bool value) {
          setState(() {
            showSubtitle = !showSubtitle;
          });
        },
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    Get.to(() => AdunForm(adun: widget.ngo));
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    widget.ngo.delete();
                  },
                  icon: const Icon(Icons.delete)),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipOval(
            child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  widget.ngo.image,
                  fit: BoxFit.cover,
                )),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: showSubtitle ? 4 : 32),
          child: Text(
            widget.ngo.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: showSubtitle
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  widget.ngo.description,
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
              widget.ngo.description,
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
                  "${widget.ngo.officeAddress}, ${widget.ngo.state}, ${widget.ngo.postCode}",
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
              Text(widget.ngo.name)
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
              Text(widget.ngo.contactNumber)
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.mail, color: Colors.red),
              ),
              Text(widget.ngo.emailAddress)
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
              Text(widget.ngo.weburl)
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
