// ignore_for_file: file_names

import 'package:bangkit/models/ngo.dart';

import 'package:bangkit/web/ngo_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({Key? key, required this.ngo}) : super(key: key);
  final Ngo ngo;

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Get.to(NGOForm(
                        ngo: widget.ngo,
                        entity: widget.ngo.entityType ?? EntityType.private));
                  },
                  icon: const Icon(Icons.edit)),
              GestureDetector(
                child: const Icon(Icons.delete),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: FutureBuilder(
                              future: widget.ngo.delete(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.active ||
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  return const Text("Successfully deleted");
                                }
                                if (snapshot.hasError) {
                                  return const Text("Error Occured");
                                }
                                return Container();
                              }),
                        );
                      });
                },
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 4, right: 4, top: 4),
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
                  widget.ngo.description +
                      "\n\nService Type : ${widget.ngo.service}",
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
              "\nService Type : ${widget.ngo.service}\n",
              maxLines: 2,
              softWrap: true,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.ngo.description,
              maxLines: 20,
              softWrap: true,
            ),
          ),
          GestureDetector(
            onTap: _launchMapURL,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.location_on, color: Colors.red),
                ),
                Flexible(
                  child: Text(
                    widget.ngo.address +
                        ",${widget.ngo.postCode}, ${widget.ngo.state}",
                    maxLines: 3,
                    softWrap: true,
                    style: const TextStyle(overflow: TextOverflow.clip),
                  ),
                )
              ],
              mainAxisSize: MainAxisSize.max,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.person_rounded, color: Colors.red),
              ),
              Text(widget.ngo.contactPersonName)
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _launchPhoneURL,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.phone, color: Colors.red),
                ),
              ),
              Text(widget.ngo.phoneNumber)
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          GestureDetector(
            onTap: _launchMailURL,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.mail, color: Colors.red),
                ),
                Text(widget.ngo.email)
              ],
              mainAxisSize: MainAxisSize.max,
            ),
          ),
          GestureDetector(
            onTap: _launchURL,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(FontAwesomeIcons.facebook, color: Colors.red),
                ),
                Text(widget.ngo.urlWeb)
              ],
              mainAxisSize: MainAxisSize.max,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _launchMailURL() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: widget.ngo.email,
    );
    String url = params.toString();
    await launch(url);
  }

  void _launchPhoneURL() async {
    await launch("tel:${widget.ngo.phoneNumber}");
  }

  void _launchURL() async {
    if (await canLaunch(widget.ngo.urlWeb)) {
      await launch(widget.ngo.urlWeb);
    }
  }

  void _launchMapURL() async {
    await launch("https://www.google.com/maps/search/${widget.ngo.address}");
  }
}
