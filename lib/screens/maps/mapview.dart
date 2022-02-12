import 'dart:async';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/area.dart';
import 'package:bangkit/models/geocoding.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:bangkit/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AreaView extends StatefulWidget {
  const AreaView({Key? key, this.area, this.coordinates}) : super(key: key);
  final Area? area;
  final LatLng? coordinates;
  @override
  State<AreaView> createState() => _AreaViewState();
}

class _AreaViewState extends State<AreaView> {
  @override
  void initState() {
    super.initState();
    if (widget.area == null) {
      _selectedType = AreaType.floodProne;
      props.add(Props.getProps(key: "Name", value: ""));
      props.add(Props.getProps(key: "Max Flood Level", value: ""));
      // props.add(Props(key: TextEditingController(), value: TextEditingController()));
    } else {
      for (var key in widget.area!.property.keys) {
        props.add(Props(key: TextEditingController(text: key), value: TextEditingController(text: widget.area!.property[key].toString())));
      }
    }

    if (widget.coordinates != null) {
      latitude.text = widget.coordinates!.latitude.toString();
      longitude.text = widget.coordinates!.longitude.toString();
    }
  }

  late AreaType _selectedType;
  List<Props> props = [];
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final location = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SizedBox(height: getHeight(context) * 0.15, child: Image.asset('assets/bina.png')),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        floatingActionButton: ElevatedButton(
            onPressed: () {
              if (widget.area != null) {
                widget.area!.update();
              } else {
                showFutureCustomDialog(
                    context: context,
                    future: Area(
                            location: location.text,
                            property: Props.convertPropsToJson(props),
                            coordinates: GeoPoint(double.parse(latitude.text), double.parse(longitude.text)),
                            type: _selectedType)
                        .add(),
                    onTapOk: () {
                      Navigator.popUntil(context, ModalRoute.withName('/map'));
                    });
              }
            },
            child: const Text("Submit")),
        body: FutureBuilder<Result?>(
            future: Area.getAddress(widget.coordinates!.latitude, widget.coordinates!.longitude),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Result result = snapshot.data as Result;
                  location.text = result.formattedAddress;
                } else {
                  location.text = '';
                }
              }
              return Row(
                children: [
                  Expanded(child: Container()),
                  SizedBox(
                    width: 600,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text("Location", style: Theme.of(context).textTheme.headline3),
                          Table(children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CustomDropDown(
                                  selectedValue: _selectedType,
                                  onChanged: (type) {
                                    setState(() {
                                      _selectedType = type as AreaType;
                                      props.clear();
                                      props.add(Props.getProps(key: "Name", value: ""));
                                      if (_selectedType == AreaType.floodProne) {
                                        props.add(Props.getProps(key: "Max Flood Level", value: ""));
                                      }
                                    });
                                  },
                                  items: AreaType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.toString()))).toList(),
                                  labelText: 'Type',
                                  hintText: '',
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CustomTextFormField(controller: location, labelText: "Location"),
                              ),
                            ]),
                          ]),
                          Table(
                            children: [
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: CustomTextFormField(controller: latitude, labelText: "Latitude"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: CustomTextFormField(controller: longitude, labelText: "Longitude"),
                                ),
                              ]),
                            ],
                          ),
                          Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: props
                                  .map((e) => TableRow(children: [
                                        // Padding(
                                        //   padding: const EdgeInsets.all(16.0),
                                        //   child: CustomTextFormField(
                                        //     controller: e.key,
                                        //     labelText: "Attributes",
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: TypeAheadFormField(
                                            textFieldConfiguration: TextFieldConfiguration(controller: e.key, decoration: inputDecoration),
                                            onSuggestionSelected: (suggestion) {
                                              e.key.text = suggestion.toString();
                                            },
                                            itemBuilder: (context, suggestion) {
                                              return ListTile(
                                                title: Text(suggestion.toString()),
                                              );
                                            },
                                            suggestionsCallback: suggestionsCallback,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: CustomTextFormField(controller: e.value, labelText: "Value"),
                                        )
                                      ]))
                                  .toList()),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  props.add(Props(key: TextEditingController(), value: TextEditingController()));
                                });
                              },
                              child: const Text("+")),
                          const SizedBox(
                            height: 400,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              );
            }));
  }

  FutureOr<Iterable> suggestionsCallback(String pattern) {
    var wordsList = ["Name", "Depth", "Max Rain", "MAx Flood Level", "Description", "Street Name"];
    if (pattern.isEmpty) {
      return wordsList;
    }
    return wordsList.where((element) => element.startsWith(pattern));
  }
}

class Props {
  Props({required this.key, required this.value});
  TextEditingController key;
  TextEditingController value;

  String get keyText => key.text;
  String get valueText => value.text;

  static getProps({required String key, required String value}) {
    return Props(key: TextEditingController(text: key), value: TextEditingController(text: value));
  }

  static convertPropsToJson(List<Props> props) {
    Map<String, dynamic> json = {};

    for (var prop in props) {
      if (prop.keyText.isNotEmpty) {
        json[prop.keyText] = prop.valueText;
      }
    }

    return json;
  }
}
