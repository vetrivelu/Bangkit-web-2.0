import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/ngo.dart';
import 'package:bangkit/models/service_category.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:bangkit/web/add_agency.dart';
import 'package:bangkit/web/add_ngo.dart';
import 'package:bangkit/web/ngo_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'repoRouter.dart';

class NgoList extends StatefulWidget {
  NgoList({Key? key, required this.query, required this.entityType})
      : super(key: key);

  final Query query;
  final String entityType;

  @override
  State<NgoList> createState() => _NgoListState();
}

class _NgoListState extends State<NgoList> {
  List<String> states = [];
  List<String> services = [];
  String? selectedService;
  late Query query;

  @override
  void initState() {
    super.initState();
    query = widget.query;
    services = serviceListController.service!;
    selectedService = serviceListController.service!.first;
  }

  void reload() {
    setState(() {
      query = widget.query;
      if (states.isNotEmpty) {
        if (states.length < 6) {
          query = query.where("state", whereIn: states);
        } else {
          var uncheckedStates = postalCodes.keys
              .toList()
              .where((element) => !states.contains(element))
              .toList();
          query = query.where("state", whereNotIn: uncheckedStates);
        }
      }
      if (selectedService != null) {
        query = query.where(
          "service",
          isEqualTo: selectedService,
        );
      }
    });
  }

  void _showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: postalCodes.keys
              .map((e) => MultiSelectItem(e.toString(), e.toString()))
              .toList(),
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
      appBar: getAppBar(context),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            widget.entityType == "NGO DATABASE"
                ? Get.to(() => const NGOForm(entity: EntityType.private))
                : Get.to(() => const NGOForm(entity: EntityType.government));
          }),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.entityType,
                          style: const TextStyle(
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
          StreamBuilder<QuerySnapshot<dynamic>>(
              stream: NgoService.getServicesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    services = snapshot.data!.docs
                        .map((e) => NgoService.fromJson(e.data()).name)
                        .toList();
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: services
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ChoiceChip(
                                      selected: getServiceChipStats(e),
                                      label: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          e.toUpperCase(),
                                          style: TextStyle(
                                              color: getServiceChipStats(e)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                      onSelected: (bool value) {
                                        if (value == true) {
                                          selectedService = e;
                                          reload();
                                        }
                                      }),
                                ))
                            .toList(),
                      ),
                    );
                  }
                }

                return const CircularProgressIndicator();
              }),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: query.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  if (streamSnapshot.hasError) {
                    return const Text("Error");
                  }
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
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
                      // Ngo.fromJson(data).update();
                      return CustomExpansionTile(ngo: Ngo.fromJson(data));
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

      //   return const Text("Eroor Occured");
      // }),
    );
  }

  getServiceChipStats(String service) {
    return selectedService == service;
  }
}
