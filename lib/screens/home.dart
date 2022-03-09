// ignore_for_file: empty_statements

import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/profile.dart';
import 'package:bangkit/models/weather.dart';
import 'package:bangkit/screens/aid%20&grants/aidpost.dart';
import 'package:bangkit/screens/maps/location_list.dart';
import 'package:bangkit/screens/page_view.dart';
import 'package:bangkit/screens/repo_list.dart';
import 'package:bangkit/screens/volunteer_list.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../services/firebase.dart';
import 'adun_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          // shadows: [Shadow(color: Colors.black, offset: Offset(0, -5))],
                          color: Colors.black,
                          fontSize: 20,

                          // decoration: TextDecoration.underline,
                          // decorationColor: Colors.blue,
                          decorationThickness: 4,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: getHeight(context) * 0.012,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CategorySquareTile(
                          assetPath: 'assets/ngologo.png',
                          label: 'Database',
                          onTap: () {
                            Get.to(() => NgoList(query: ngos.where("entityType", isEqualTo: 1), entityType: 'NGO DATABASE'));
                          }),
                      CategorySquareTile(
                          assetPath: 'assets/aa.png',
                          label: 'Gov Agencies',
                          onTap: () {
                            Get.to(() => NgoList(query: ngos.where("entityType", isEqualTo: 0), entityType: 'GOVERNMENT AGENCIES'));
                          }),
                      CategorySquareTile(
                          assetPath: 'assets/adun.png',
                          label: 'Ahli Parlimen & ADUN',
                          onTap: () {
                            Get.to(() => AdunList());
                          }),
                      CategorySquareTile(
                          assetPath: 'assets/volunteer.png',
                          label: 'Volunteers List',
                          onTap: () {
                            Get.to(() => const VolunteerList());
                          }),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, top: 10, right: 8),
                      child: Text(
                        "Disaster Information",
                        style: TextStyle(
                          // shadows: [Shadow(color: Colors.black, offset: Offset(0, -5))],
                          color: Colors.black,
                          fontSize: 20,
                          // decoration: TextDecoration.underline,
                          // decorationColor: Colors.blue,
                          // decorationThickness: 4,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: getHeight(context) * 0.02,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    runSpacing: 10,
                    children: [
                      CategorySquareTile(
                          assetPath: 'assets/aidgranticon.webp',
                          label: 'Aid & Grants',
                          onTap: () {
                            // launch("https://ereporting.rmp.gov.my/index.aspx");
                            // Get.to(() => const WebViewer(url: "https://ereporting.rmp.gov.my/index.aspx"));
                            Get.to(() => const AidAndGrants());
                            //  pageController.load!(0);
                          }),

                      CategorySquareTile(
                          assetPath: 'assets/floodMarker.png',
                          label: 'Map Location',
                          onTap: () {
                            // pageController.load!(5);
                            Get.toNamed("/map");
                          }),

                      CategorySquareTile(
                          assetPath: 'assets/dam.jpeg',
                          label: 'Location List',
                          onTap: () {
                            // pageController.pageNumber = 7;
                            Get.to(() => const LocationList());
                          }),

                      // CategorySquareTile(
                      //     assetPath: 'assets/Rebuild.png',
                      //     label: 'Rebuild',
                      //     onTap: () {
                      //       pageController.pageNumber = 4;
                      //       Navigator.of(context).popAndPushNamed('/bottomRoute');
                      //     }),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // getImageTile('https://cimages.milaap.org/milaap/image/upload/c_fill,g_faces,h_452,w_603/v1639160721/production/images/campaign/427988/WhatsApp_Image_2021-12-10_at_11.50.38_PM_yy8krg_1639160725.jpg'),
              // getImageTile('https://cimages.milaap.org/milaap/image/upload/c_fill,g_faces,h_452,w_603/v1639992568/production/images/campaign/432649/WhatsApp_Image_2021-12-20_at_14.34.04_ki3c5i_1639992571.jpg'),
              // getImageTile('https://cimages.milaap.org/milaap/image/upload/c_fill,g_faces,h_452,'
              //     'w_603/v1637742107/production/images/campaign/419357/IMG_20210305_110858_fiij8t_1637742113.jpg'),
            ],
          ),
        ),
      ),
    );
  }
}

class CategorySquareTile extends StatelessWidget {
  const CategorySquareTile({
    Key? key,
    required this.assetPath,
    required this.label,
    this.onTap,
  }) : super(key: key);
  final String assetPath;
  final String label;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 10,
            width: MediaQuery.of(context).size.width / 10,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ElevatedButton(
                  onPressed: onTap,
                  child: Image.asset(
                    assetPath,
                    fit: BoxFit.fitHeight,
                    scale: 0.1,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: const BorderSide(color: Colors.white))))),
            ),
          ),
          Text(label),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                  ),
                  Text(
                    profile.primaryAddress.state.toString(),
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  profile.primaryAddress.pincode,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8),
        child: Container(
          width: 70,
          height: 70,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/man.png',
          ),
        ),
      ),
      toolbarHeight: 80,
      elevation: 0,
      backgroundColor: const Color(0xFFF4F4F4),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            profile.name,
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                  child: Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                    child: TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF82878C),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x004B39EF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x004B39EF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF151B1E),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                const Icon(
                  Icons.filter_alt,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
