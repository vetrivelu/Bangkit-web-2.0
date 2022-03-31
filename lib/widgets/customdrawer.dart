import 'dart:math' as math show pi;

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sidebar ui',
      home: Scaffold(
        body: SidebarPage(),
      ),
    );
  }
}

class SidebarPage extends StatefulWidget {
  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = AssetImage('assets/man.png');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'NGO DATABASE',
        icon: Icons.assessment,
        onPressed: () => setState(() => _headline = 'NGO DATABASE'),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'GOVERNMENT AGENCY',
        icon: Icons.icecream,
        onPressed: () => setState(() => _headline = 'GOVERNMENT AGENCY'),
      ),
      CollapsibleItem(
        text: 'ADUN LIST',
        icon: Icons.search,
        onPressed: () => setState(() => _headline = 'ADUN LIST'),
      ),
      CollapsibleItem(
        text: 'VOLUNTEER LIST',
        icon: Icons.notifications,
        onPressed: () => setState(() => _headline = 'VOLUNTEER LIST'),
      ),
      CollapsibleItem(
        text: 'AID & GRANT',
        icon: Icons.settings,
        onPressed: () => setState(() => _headline = 'AID & GRANT'),
      ),
      CollapsibleItem(
        text: 'MAP ',
        icon: Icons.home,
        onPressed: () => setState(() => _headline = 'MAP'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        isCollapsed: true,
        items: _items,
        avatarImg: _avatarImg,
        title: 'John Smith',
        onTitleTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Yay! Flutter Collapsible Sidebar!')));
        },
        body: _body(size, context),
        backgroundColor: Colors.black,
        selectedTextColor: Colors.limeAccent,
        textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        sidebarBoxShadow: [
          BoxShadow(
            color: Colors.indigo,
            blurRadius: 20,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
          BoxShadow(
            color: Colors.green,
            blurRadius: 50,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
        ],
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
