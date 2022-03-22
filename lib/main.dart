import 'package:bangkit/models/ngo.dart';
import 'package:bangkit/routers/bottom_route.dart';
import 'package:bangkit/routers/landing_page.dart';
import 'package:bangkit/web/add_adun.dart';
import 'package:bangkit/web/ngo_form.dart';
import 'package:bangkit/web/post_form.dart';
import 'package:bangkit/web/web_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'controllers/page_controller.dart';
import 'firebase_options.dart';
import 'routers/home_route.dart';
import 'screens/maps/all_items_map.dart';
import 'web/add_ngo.dart';
import 'web/adun_form.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController());
  Get.put(IndexController());
  Get.put(ProfileController());
  Get.put(ServiceListController());
  Get.put(DamLinkController());
  Get.put(MapIconsController());

  await markerController.loadIcons();
  await MapIconsController.loadMarkerInfo();

  // serviceListController.service = await NgoService.getServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/bottomRoute': (context) => BottomRouter(),
        '/homeRoute': (context) => const HomeRoute(),
        '/map': (context) => AllMap(),
        '/NGOForm': (context) => const NGOForm(
              entity: EntityType.private,
            ),
        '/Postform': (context) => PostForm(),
        '/AddAdun': (context) => AddAdun(),
        '/AdunForm': (context) => AdunForm(),
      },
      theme: ThemeData(
        fontFamily: 'Roboto',
        iconTheme: const IconThemeData(color: Colors.black),
        primaryColor: const Color(0xFF00b3df),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          labelStyle: TextStyle(color: Colors.pink[800]), // color for text
          indicator: const BoxDecoration(color: Color(0xFF00b3df)),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        bottomAppBarTheme: const BottomAppBarTheme(),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 5, backgroundColor: Colors.blue),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        chipTheme: const ChipThemeData(
          elevation: 4,
          backgroundColor: Colors.white,
          selectedColor: Color(0xFF22A8E0),
          disabledColor: Colors.white,
          showCheckmark: false,
          padding: EdgeInsets.all(0.0),
          brightness: Brightness.light,
          secondaryLabelStyle: TextStyle(color: Colors.black),
          labelStyle: TextStyle(color: Colors.white),
          secondarySelectedColor: Color(0xFF63e5ff),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF00b3df)))),
      ),
      home: const LandingPage(),
    );
  }
}

class AddApp extends StatefulWidget {
  AddApp({Key? key}) : super(key: key);

  @override
  _AddAppState createState() => _AddAppState();
}

class _AddAppState extends State<AddApp> {
  final pageController = PageController();
  bool toggle = true;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              const SizedBox(height: 60),
              ListTile(
                title: const Text("ADD ADUN"),
                onTap: () {
                  setState(() {
                    pageController.jumpToPage(0);
                  });
                },
              ),
              ListTile(
                title: const Text("ADD NGO"),
                onTap: () {
                  setState(() {
                    pageController.jumpToPage(1);
                  });
                },
              ),
              // ListTile(
              //   title: const Text("ADD REBUILD"),
              //   onTap: () {
              //     setState(() {
              //       pageController.jumpToPage(2);
              //     });
              //   },
              // ),
            ],
          ),
        ),
        // body: TabBarView(
        //   children: [AddAgency(), AddNgo(), AddAdun(), const AddService(), AddPost()],
        // ),
        body: const HomePage(),
      ),
    );
  }
}
