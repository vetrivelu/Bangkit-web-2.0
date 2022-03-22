import 'package:bangkit/screens/home.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  static const List<Widget> _widgetOptions = <Widget>[

    HomePage(),

  ];




  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(

            flex: 1,
            child: Drawer()),

        Expanded(
            flex:5,child: HomePage())
      ],

    );
  }
}
