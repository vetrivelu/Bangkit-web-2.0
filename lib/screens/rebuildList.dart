import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/models/rebuild.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RebuildList extends StatefulWidget {
  RebuildList({Key? key, required this.query}) : super(key: key);

  final String query;

  @override
  State<RebuildList> createState() => _RebuildListState();
}

class _RebuildListState extends State<RebuildList> {
  List<String> states = [];
  // ServiceType serviceType = ServiceType.cleaning;
  // bool isGovernment = true;

  late Query query;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query = rebuilds;
  }

  Set<dynamic> filters = {};
  void reload() {
    setState(() {
      query = rebuilds;
      filters = {};

      if (states.isNotEmpty) {
        query = query.where("state", whereIn: states);
      }
      // query = isGovernment ? query.where("entityType", isEqualTo: 0) : rebuilds.where("entityType", isEqualTo: 1);
      // if (widget.query != "repos") {
      //   query = query.where("serviceType", isEqualTo: serviceType.index);
      // }
    });
  }

  get showChips => widget.query == "repos";

  void _showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: postalCodes.keys.map((e) => MultiSelectItem(e.toString(), e.toString())).toList(),
          initialValue: states,
          onConfirm: (values) async {
            states = values.map((e) => e.toString()).toList();
            reload();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Image.asset('assets/bina.png', height: 150),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            pageController.pageNumber = 0;
            Navigator.popAndPushNamed(context, '/bottomRoute');
          },
          child: const Icon(Icons.arrow_back, color: Colors.blue),
        ),
      ),
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
                      'REBUILDS',
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
          // showChips
          //     ? Container()
          //     : Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.all(4.0),
          //             child: FilterChip(
          //                 selected: isGovernment,
          //                 shape: const StadiumBorder(side: BorderSide(color: Color(0xFF22A8E0))),
          //                 label: Text("GOVERNMENT", style: TextStyle(color: isGovernment ? Colors.white : const Color(0xFF22A8E0))),
          //                 onSelected: (bool value) {
          //                   isGovernment = true;
          //                   reload();
          //                 }),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(4.0),
          //             child: FilterChip(
          //                 selected: !isGovernment,
          //                 shape: const StadiumBorder(side: BorderSide(color: Color(0xFF22A8E0))),
          //                 label: Text("PRIVATE", style: TextStyle(color: !isGovernment ? Colors.white : const Color(0xFF22A8E0))),
          //                 onSelected: (bool value) {
          //                   isGovernment = false;
          //                   reload();
          //                 }),
          //           )
          //         ],
          //       ),
          // showChips
          //     ? Container()
          //     : SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           children: ServiceType.values
          //               .map((e) => Padding(
          //                     padding: const EdgeInsets.all(4.0),
          //                     child: ChoiceChip(
          //                         selected: getServiceChipStats(e),
          //                         label: Padding(
          //                           padding: const EdgeInsets.all(8.0),
          //                           child: Text(
          //                             e.toString().split('.').last.toUpperCase(),
          //                             style: TextStyle(color: getServiceChipStats(e) ? Colors.white : Colors.black),
          //                           ),
          //                         ),
          //                         onSelected: (bool value) {
          //                           if (value == true) {
          //                             serviceType = e;
          //                           }
          //                           reload();
          //                         }),
          //                   ))
          //               .toList(),
          //         ),
          //       ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: query.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                  print(streamSnapshot.hasData);
                  return ListView(
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: streamSnapshot.data!.docs.map((snapshot) {
                      var data = snapshot.data()! as Map<String, dynamic>;
                      // print("I am data $data");
                      // rebuild.fromJson(data).update();
                      return CustomExpansionTile(rebuild: Rebuild.fromJson(data));
                    }).toList(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // getServiceChipStats(ServiceType e) {
  //   return e == serviceType;
  // }
}

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({Key? key, required this.rebuild}) : super(key: key);
  final Rebuild rebuild;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool showSubtitle = true;

  @override
  Widget build(BuildContext context) {
    // rebuild.update();
    return Card(
      child: ExpansionTile(
        onExpansionChanged: (bool value) {
          setState(() {
            showSubtitle = !showSubtitle;
          });
        },
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            child: ClipOval(
              child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    widget.rebuild.image,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: showSubtitle ? 4 : 32),
          child: Text(
            widget.rebuild.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: showSubtitle
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  widget.rebuild.description,
                  maxLines: 3,
                  softWrap: true,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
              )
            : null,
        iconColor: Colors.red,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.location_on, color: Colors.red),
              ),
              Flexible(
                child: Text(
                  widget.rebuild.address,
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
              Text(widget.rebuild.contactPersonName)
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
              Text(widget.rebuild.phoneNumber)
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
              Text(widget.rebuild.email)
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.rebuild.description,
              maxLines: 20,
              softWrap: true,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
