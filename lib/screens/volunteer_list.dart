import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/profile.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:bangkit/widgets/photo_viewer.dart';
import 'package:flutter/material.dart';

class VolunteerList extends StatefulWidget {
  const VolunteerList({Key? key, this.setIndex}) : super(key: key);
  final void Function(int)? setIndex;

  @override
  State<VolunteerList> createState() => _VolunteerListState();
}

class _VolunteerListState extends State<VolunteerList> {
  @override
  void initState() {
    super.initState();
    loadItems();
    loadQuery();
  }

  void loadQuery() {
    setState(() {
      query = users.where("isVolunteer", isEqualTo: true);
      _selectedState = _selectedState ?? 'All';
      if (_selectedState != 'All' && _selectedState != null) {
        query = query.where(_selectedState!, isEqualTo: true);
      }
      if (selectedServices.isNotEmpty) {
        query = query.where("services", arrayContainsAny: selectedServices);
      }
    });
  }

  final states = postalCodes.keys.toList();
  late Query query;
  String? _selectedState;
  List<String> selectedServices = [];

  DropdownMenuItem<String> nullItem = const DropdownMenuItem(
    value: "All",
    child: Text("All"),
  );

  final List<DropdownMenuItem<String>> _stateItems = [];
  void loadItems() {
    _stateItems.add(nullItem);
    _stateItems.addAll(postalCodes.keys.map((state) => DropdownMenuItem(value: state, child: Text(state))));
  }

  // get items => nullItem.addAll(postalCodes.keys.map((state) => DropdownMenuItem(value: state, child: Text(state))).toList(growable: false));
  // Iterable get pincodes => _selectedState != null ? postalCodes[_selectedState]!.map((e) => e["postCode"]) : [];
  // get pincodeItems => pincodes.map((e) => DropdownMenuItem(value: e as String, child: Text(e))).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(context),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'VOLUNTEER LIST',
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
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SizedBox(
                    width: getWidth(context) * 0.4,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(border: InputBorder.none),
                      value: _selectedState,
                      items: _stateItems,
                      onChanged: (state) {
                        _selectedState = state as String? ?? _selectedState;
                        loadQuery();
                      },
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: serviceListController.service!
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ChoiceChip(
                              selected: getServiceChipStats(e),
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e.toUpperCase(),
                                  style: TextStyle(color: getServiceChipStats(e) ? Colors.white : Colors.black),
                                ),
                              ),
                              onSelected: (bool value) {
                                if (value == true) {
                                  selectedServices.add(e);
                                } else {
                                  selectedServices.removeWhere((element) => element == e);
                                }
                                loadQuery();
                              }),
                        ))
                    .toList(),
              ),
            ),
            const Divider(),
            Expanded(
              child: StreamBuilder(
                stream: query.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active || snapshot.hasData) {
                    var documents = snapshot.data!.docs;
                    List<Profile> profiles = documents.map((e) => Profile.fromJson(e.data() as Map<String, dynamic>)).toList();
                    return ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      // mainAxisSize: MainAxisSize.min,
                      children: profiles.map((e) => CustomExpansionTile(profile: e)).toList(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("An error has occured"));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ));
  }

  getServiceChipStats(String e) {
    int count = selectedServices.where((element) => element == e).toList().length;
    return count != 0 ? true : false;
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

  final PageController _pageController = PageController();

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
                            widget.profile.approveVolunteer();
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
                            return PhotoViewer(urls: widget.profile.documents.map((e) => e.toString()).toList());
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     const Padding(
          //       padding: EdgeInsets.all(8),
          //       child: Icon(Icons.location_on, color: Colors.red),
          //     ),
          //     Flexible(
          //       child: Text(
          //         // "${widget.profile.secondaryAddress.fullAddress}",
          //         maxLines: 3,
          //         softWrap: true,
          //         style: const TextStyle(overflow: TextOverflow.clip),
          //       ),
          //     )
          //   ],
          //   mainAxisSize: MainAxisSize.max,
          // ),
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
