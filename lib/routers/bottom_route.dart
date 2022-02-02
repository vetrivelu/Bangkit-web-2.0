import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/profile/profile.dart';
import 'package:bangkit/routers/home_route.dart';
import 'package:bangkit/screens/aid%20&grants/aidpost.dart';
import 'package:bangkit/screens/feedback_list.dart';
import 'package:flutter/material.dart';

class BottomRouter extends StatefulWidget {
  BottomRouter({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomRouter> createState() => _BottomRouterState();
}

class _BottomRouterState extends State<BottomRouter> {
  int _selectedIndex = 0;

  getWidgets(int index) {
    switch (index) {
      case 0:
        return const HomeRoute();
      case 1:
        return const AidAndGrants();
      case 2:
        return const FeedbackList();
      case 3:
        return ProfileWidget(profileModel: profileController.profile!);
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: getWidgets(_selectedIndex),
  //     bottomNavigationBar: Padding(
  //       padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10, top: 10),
  //       child: Card(
  //         elevation: 5,
  //         shadowColor: Colors.lightBlueAccent,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(18.0),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: BottomNavigationBar(
  //             // showUnselectedLabels: true,
  //             selectedItemColor: Colors.blue,
  //             unselectedItemColor: Colors.grey,
  //             elevation: 0,
  //             items: const [
  //               BottomNavigationBarItem(
  //                 icon: Icon(Icons.home),
  //                 label: 'Home',
  //                 tooltip: 'Home',

  //                 // backgroundColor: Colors.red,
  //               ),
  //               BottomNavigationBarItem(
  //                 icon: ImageIcon(AssetImage('assets/aid.png')),
  //                 label: 'Aid & Grants',
  //                 tooltip: 'Home',

  //                 // backgroundColor: Colors.red,
  //               ),
  //               BottomNavigationBarItem(
  //                 icon: Icon(Icons.feedback),
  //                 label: 'Feedback',
  //                 tooltip: 'Home',

  //                 // backgroundColor: Colors.red,
  //               ),
  //               BottomNavigationBarItem(
  //                 icon: Icon(Icons.person),
  //                 label: 'Profile',
  //                 tooltip: 'Home',
  //                 // backgroundColor: Colors.red,
  //               ),
  //             ],
  //             currentIndex: _selectedIndex,
  //             backgroundColor: Colors.white,
  //             onTap: (int index) {
  //               setState(() {
  //                 pageController.pageNumber = 0;
  //                 _selectedIndex = index;
  //               });
  //             },
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          return true;
        } else {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        body: getWidgets(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              tooltip: 'Home',

              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/aid.png')),
              label: 'Aid & Grants',
              tooltip: 'Home',

              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feedback),
              label: 'Feedback',
              tooltip: 'Home',

              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              tooltip: 'Home',
              // backgroundColor: Colors.red,
            ),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: Colors.white,
          onTap: (int index) {
            setState(() {
              pageController.pageNumber = 0;
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
