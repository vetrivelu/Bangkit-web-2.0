// ignore_for_file: prefer_const_constructors

import 'package:bangkit/weather/weatherwidgets.dart';
import 'package:bangkit/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({Key? key}) : super(key: key);

  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  int selectedIndex = 0;

  void setIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
    print('selected Index $selectedIndex');
  }

  @override
  Widget build(BuildContext context) {
    Widget getWidget() {
      switch (selectedIndex) {
        case 0:
          return WeatherBoard(
            assetlocation:
                'https://cdn-icons.flaticon.com/png/512/2862/premium/2862807.png?token=exp=1641364165~hmac=74e2b13336d6a2655599b8d5b21d6f8d',
          );
        case 1:
          return VideoApp(
              url: 'https://media.istockphoto'
                  '.com/videos/hurricane-infrared-satellite-view-video-id91487341');

        case 2:
          return VideoApp(
            url: 'https://media.istockphoto.com/videos/hurricane-infrared-satellite-view-video-id91487341',
          );

        case 4:
          return WeatherBoard2();
        case 5:
          return VideoApp(
            url: 'https://media.istockphoto.com/videos/hurricane-infrared-satellite-view-video-id91487341',
          );
        default:
          return WeatherBoard(
            assetlocation:
                'https://cdn-icons.flaticon.com/png/512/2862/premium/2862807.png?token=exp=1641364165~hmac=74e2b13336d6a2655599b8d5b21d6f8d',
          );
      }
    }

    Widget getWeather() {
      switch (selectedIndex) {
        case 0:
          return WeatherList();
        case 1:
          return Weatherlist2();
        case 2:
          return WeatherList();
        case 3:
          return Weatherlist2();
        case 4:
          return Weatherlist3();
        case 5:
          return VideoApp(
            url: 'https://media.istockphoto.com/videos/hurricane-infrared-satellite-view-video-id91487341',
          );
        default:
          return WeatherBoard(
            assetlocation:
                'https://cdn-icons.flaticon.com/png/512/2862/premium/2862807.png?token=exp=1641364165~hmac=74e2b13336d6a2655599b8d5b21d6f8d',
          );
      }
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const <Color>[Colors.red, Colors.blue],
        ),
      ),
      child: Scaffold(
        // floatingActionButton: SpeedDialFabWidget(
        //   secondaryIconsList: const [
        //     FontAwesomeIcons.exclamation,
        //     FontAwesomeIcons.bullhorn,
        //     Icons.air,
        //     Icons.radar,
        //     Icons.satellite_sharp,
        //   ],
        //   secondaryIconsText: [
        //     "copy",
        //     "copy",
        //     "copy",
        //     "paste",
        //     "cut",
        //   ],
        //   secondaryIconsOnPress: [
        //     () => setIndex(4),
        //     () => setIndex(3),
        //     () => setIndex(2),
        //     () => setIndex(1),
        //     () => setIndex(0),
        //   ],
        //   secondaryBackgroundColor: Colors.red,
        //   secondaryForegroundColor: Colors.white,
        //   primaryBackgroundColor: Colors.red,
        //   primaryForegroundColor: Colors.black,
        // ),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              width: 70,
              height: 70,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/man.png',
              ),
            ),
          ),
          toolbarHeight: 80,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 25),
          //     child: Icon(
          //       Icons.settings,
          //       size: 30,
          //       color: Colors.grey,
          //     ),
          //   ),
          // ],
          elevation: 1,
          backgroundColor: Colors.white,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'Andrew simons',
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
        ),
        backgroundColor: Color(0xFFF1F4F8),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Generated code for this reviewRow_4 Widget...
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 12, 0, 16),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.96,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: getWidget(),
                  ),
                ),

                getWeather(),
              ],
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.blueGrey[700],
    //   floatingActionButton: SpeedDialFabWidget(
    //     secondaryIconsList: [
    //       Icons.content_copy,
    //       Icons.content_paste,
    //       Icons.content_cut,
    //     ],
    //     secondaryIconsText: [
    //       "copy",
    //       "paste",
    //       "cut",
    //     ],
    //     secondaryIconsOnPress: [
    //           () => {},
    //           () => {},
    //           () => {},
    //     ],
    //     secondaryBackgroundColor: Colors.grey[900],
    //     secondaryForegroundColor: Colors.grey[100],
    //     primaryBackgroundColor: Colors.grey[900],
    //     primaryForegroundColor: Colors.grey[100],
    //   ),
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text('test'),
    //   ),
    //   body: SafeArea(
    //     child: Center(
    //       child: Text(
    //         "Test Speed Dial FAB Example",
    //         style: TextStyle(
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // return Scaffold(
    //   floatingActionButton: ExpandableFab(
    //     distance: 112.0,
    //     children: [
    //       ActionButton(
    //         onPressed: (){
    //           selectedIndex=0;
    //         },
    //         icon: const Icon(Icons.format_size),
    //       ),
    //       ActionButton(
    //         onPressed: (){
    //           selectedIndex=0;
    //         },
    //         icon: const Icon(Icons.format_size),
    //       ),
    //       ActionButton(
    //         onPressed: (){
    //           selectedIndex=1;
    //         },
    //         icon: const Icon(Icons.insert_photo),
    //       ),
    //       ActionButton(
    //         onPressed: (){
    //           selectedIndex=2;
    //         },
    //         icon: const Icon(Icons.videocam),
    //       ),
    //     ],
    //   ),
    //
    //   body:  Center(
    //     child: _widgetOptions.elementAt(selectedIndex),
    //   ),
    //
    //
    //
    //
    // );
  }
}
