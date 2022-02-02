import 'package:flutter/material.dart';




class Warning extends StatelessWidget {
  const Warning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset('assets/Screenshot_20220102-230458_myCuaca.jpg'),
      ),
    );
  }
}
