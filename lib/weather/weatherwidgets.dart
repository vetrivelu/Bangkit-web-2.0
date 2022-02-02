import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/weather/warning.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WeatherBoard extends StatelessWidget {
  const WeatherBoard({Key? key, required this.assetlocation}) : super(key: key);

  final String assetlocation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context) * 0.75,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '01:23',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Sunny',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(height: 20),
                Text(
                  'Thursday',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'January 1',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFFFF0808),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  assetlocation,
                  fit: BoxFit.contain,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Kuala Lumpur',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherBoard2 extends StatefulWidget {
  const WeatherBoard2({Key? key}) : super(key: key);

  @override
  _WeatherBoard2State createState() => _WeatherBoard2State();
}

class _WeatherBoard2State extends State<WeatherBoard2> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Text(
                  'Earth Quake',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: Text(
                  'Thursday',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                'January 1',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFFFF0808),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(70, 0, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/733/733077.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Text(
                  'Kuala Lumpur',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.red,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WeatherList extends StatefulWidget {
  const WeatherList({Key? key}) : super(key: key);

  @override
  _WeatherListState createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 24),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.96,
        height: MediaQuery.of(context).size.height * 0.7,
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
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.wb_sunny,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Sunday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.wb_sunny,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Monday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.wb_sunny,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Tuesday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.wb_sunny,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Wednesday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.wb_sunny,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Thursday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.wb_sunny,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Friday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.wb_sunny,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Saturday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.wb_sunny,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Sunday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Weatherlist2 extends StatefulWidget {
  const Weatherlist2({Key? key}) : super(key: key);

  @override
  _Weatherlist2State createState() => _Weatherlist2State();
}

class _Weatherlist2State extends State<Weatherlist2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 24),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.96,
        height: MediaQuery.of(context).size.height * 0.7,
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
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.air,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Sunday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.air,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Monday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.air,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Tuesday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.air,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Wednesday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.air,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Thursday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.air,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Friday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.air,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Saturday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.air,
                              color: Colors.red,
                              size: 50,
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                              child: Text(
                                'Sunday',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'wind',
                                    style: TextStyle(),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '22kmph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'visibility',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '5kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 16, 0),
                          child: Text(
                            '32°',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Weatherlist3 extends StatefulWidget {
  const Weatherlist3({Key? key}) : super(key: key);

  @override
  _Weatherlist3State createState() => _Weatherlist3State();
}

class _Weatherlist3State extends State<Weatherlist3> {
  @override
  Widget build(BuildContext context) {
    bool _customTileExpanded = false;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 24),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.96,
        height: MediaQuery.of(context).size.height * 0.7,
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
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                  child: ExpansionTile(
                    leading: Icon(FontAwesomeIcons.exclamationCircle),
                    title: const Text('Earth Quake'),
                    subtitle: const Text('Current Update'),
                    trailing: Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_circle
                          : Icons.arrow_drop_down,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => _customTileExpanded = expanded);
                    },
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    leading: Icon(FontAwesomeIcons.exclamationCircle),
                    title: const Text('Earth Quake'),
                    subtitle: const Text('Current Update'),
                    trailing: Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_circle
                          : Icons.arrow_drop_down,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => _customTileExpanded = expanded);
                    },
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    leading: Icon(FontAwesomeIcons.exclamationCircle),
                    title: const Text('Earth Quake'),
                    subtitle: const Text('Current Update'),
                    trailing: Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_circle
                          : Icons.arrow_drop_down,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => _customTileExpanded = expanded);
                    },
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    leading: Icon(FontAwesomeIcons.exclamationCircle),
                    title: const Text('Earth Quake'),
                    subtitle: const Text('Current Update'),
                    trailing: Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_circle
                          : Icons.arrow_drop_down,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => _customTileExpanded = expanded);
                    },
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    leading: Icon(FontAwesomeIcons.exclamationCircle),
                    title: const Text('Earth Quake'),
                    subtitle: const Text('Current Update'),
                    trailing: Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_circle
                          : Icons.arrow_drop_down,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => _customTileExpanded = expanded);
                    },
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    leading: Icon(FontAwesomeIcons.exclamationCircle),
                    title: const Text('Earth Quake'),
                    subtitle: const Text('Current Update'),
                    trailing: Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_circle
                          : Icons.arrow_drop_down,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => _customTileExpanded = expanded);
                    },
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    leading: Icon(FontAwesomeIcons.exclamationCircle),
                    title: const Text('Earth Quake'),
                    subtitle: const Text('Current Update'),
                    trailing: Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_circle
                          : Icons.arrow_drop_down,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => _customTileExpanded = expanded);
                    },
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    leading: Icon(FontAwesomeIcons.exclamationCircle),
                    title: const Text('Earth Quake'),
                    subtitle: const Text('Current Update'),
                    trailing: Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_circle
                          : Icons.arrow_drop_down,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                      ListTile(
                        title: Text(
                          'Earth Quake Information',
                        ),
                        onTap: () {
                          Get.to(Warning());
                        },
                        subtitle: Text('2022 Jan 1  10:10 pm'),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => _customTileExpanded = expanded);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
