import 'package:bangkit/controllers/layoutcontroller.dart';
import 'package:bangkit/screens/adun_list.dart';
import 'package:bangkit/screens/aid%20&grants/aidpost.dart';
import 'package:bangkit/screens/maps/location_list.dart';
import 'package:bangkit/screens/repo_list.dart';
import 'package:bangkit/screens/volunteer_list.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show pi;

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = const AssetImage('assets/man.png');
  int _selectedIndex = 0;

  bool isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  final pages = [
    // HomePage(),
    NgoList(query: ngos.where("entityType", isEqualTo: 1), entityType: 'NGO DATABASE'),
    NgoList(query: ngos.where("entityType", isEqualTo: 0), entityType: 'GOVERNMENT AGENCIES'),
    AdunList(),
    const VolunteerList(),
    const AidAndGrants(),
    const LocationList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'NGO DATABASE',
        icon: Icons.assessment,
        onPressed: () {
          setState(() {
            layoutController.pageIndex = 0;
            layoutController.controller.jumpToPage(0);
          });
        },
        isSelected: true,
      ),
      CollapsibleItem(
          text: 'GOVERNMENT AGENCIES',
          icon: Icons.icecream,
          onPressed: () {
            setState(() {
              layoutController.pageIndex = 1;
              layoutController.controller.jumpToPage(1);
            });
          }),
      CollapsibleItem(
          text: 'ADUN LIST',
          icon: Icons.search,
          onPressed: () {
            setState(() {
              layoutController.pageIndex = 2;
              layoutController.controller.jumpToPage(2);
            });
          }),
      CollapsibleItem(
          text: 'VOLUNTEER LIST',
          icon: Icons.notifications,
          onPressed: () {
            setState(() {
              layoutController.pageIndex = 3;
              layoutController.controller.jumpToPage(3);
            });
          }),
      CollapsibleItem(
        text: 'AID & GRANTS',
        icon: Icons.settings,
        onPressed: () {
          setState(() {
            layoutController.pageIndex = 4;
            layoutController.controller.jumpToPage(4);
          });
        },
      ),
      CollapsibleItem(
        text: 'MAP LOCATIONS',
        icon: Icons.home,
        onPressed: () {
          setState(() {
            layoutController.pageIndex = 5;
            layoutController.controller.jumpToPage(5);
          });
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            AnimatedContainer(
              width: isCollapsed ? 270 : 80,
              duration: const Duration(milliseconds: 300),
              child: CollapsibleSidebar(
                onToggleTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },

                // isCollapsed: isCollapsed,
                items: _items,
                avatarImg: _avatarImg,
                title: 'John Smith',
                onTitleTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Yay! Flutter Collapsible Sidebar!')));
                },
                body: const Text(''),
                backgroundColor: Colors.white,
                selectedTextColor: Colors.white,
                textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                titleStyle: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                toggleTitleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

                sidebarBoxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 20,
                    spreadRadius: 0.01,
                    offset: Offset(3, 3),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 20,
                    spreadRadius: 0.001,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: layoutController.controller,
                itemCount: pages.length,
                itemBuilder: ((context, index) => pages[index]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: Center(
        child: Transform.rotate(
          angle: math.pi / 2,
          child: Transform.translate(
            offset: Offset(-size.height * 0.3, -size.width * 0.23),
            child: Text(
              _headline,
              style: Theme.of(context).textTheme.headline1,
              overflow: TextOverflow.visible,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }
}
