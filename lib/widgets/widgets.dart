import 'package:bangkit/models/response.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../constants/themeconstants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.labelText,
    this.obscureText = false,
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  final String? labelText;
  final bool obscureText;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(minHeight: 60, maxWidth: getWidth(context) / 4),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(labelText ?? ''),
        ),
        subtitle: TextFormField(
          onChanged: onChanged,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            // labelText: labelText,
            labelStyle: const TextStyle(
              fontFamily: 'Lexend Deca',
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Lexend Deca',
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFDBE2E7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFDBE2E7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.8),
            contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
          ),
          style: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF2B343A),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class CustomTextBox extends StatelessWidget {
  const CustomTextBox(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.onTap,
      this.leftPad = 20,
      this.maxLines,
      this.prefixIcon,
      this.enabled})
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double? leftPad;
  final int? maxLines;
  final bool? enabled;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        fontFamily: 'Lexend Deca',
        color: Color(0xFFEF4C43),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        fontFamily: 'Lexend Deca',
        color: Color(0xFF95A1AC),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFFDBE2E7),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFFDBE2E7),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
      prefixIcon: prefixIcon,
    );
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, leftPad!, 16),
      child: TextFormField(
        maxLines: maxLines,
        onChanged: onChanged,
        onTap: onTap,
        keyboardType: keyboardType,
        enabled: enabled,
        controller: controller,
        obscureText: false,
        decoration: inputDecoration,
        style: const TextStyle(
          fontFamily: 'Lexend Deca',
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.onTap,
    this.leftPad = 20,
    required this.selectedValue,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final Object? selectedValue;

  final void Function(Object?)? onChanged;
  final void Function()? onTap;
  final double? leftPad;

  final List<DropdownMenuItem<Object>>? items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, leftPad!, 16),
      child: DropdownButtonFormField(
        isExpanded: false,
        value: selectedValue,
        onChanged: onChanged,
        onTap: onTap,
        decoration: InputDecoration(
          constraints: const BoxConstraints.expand(height: 65),
          labelText: labelText,
          labelStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color(0xFFEF4C43),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF95A1AC),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: const Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: const Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
        ),
        style: const TextStyle(
          fontFamily: 'Lexend Deca',
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        items: items,
      ),
    );
  }
}

class RadioButton extends StatefulWidget {
  const RadioButton({required this.function});
  final VoidCallback function;
  @override
  State<RadioButton> createState() => _RadioButtonState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _RadioButtonState extends State<RadioButton> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('In Campus'),
          leading: Radio<bool>(
              value: true,
              groupValue: true,
              onChanged: (bool? vale) {
                widget.function();
              }),
        ),
        ListTile(
          title: const Text('Out Campus'),
          leading: Radio<bool>(
              value: false,
              groupValue: false,
              onChanged: (bool? vale) {
                widget.function();
              }),
        ),
      ],
    );
  }
}

class VideoItem extends StatefulWidget {
  const VideoItem({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _controller.value.isInitialized
          ? SizedBox(
              width: 100.0,
              height: 56.0,
              child: VideoPlayer(_controller),
            )
          : const CircularProgressIndicator(),
      title: Text(widget.url.split('/').last),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoApp(url: widget.url),
          ),
        );
      },
    );
  }
}

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key, required this.url}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
  final String url;
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: VideoPlayer(_controller))
            : Container(),
      ),
      // floatingActionButtonLocation : FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   // backgroundColor : Colors.transperent
      //   onPressed: () {
      //     setState(() {
      //       _controller.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   // child: Icon(
      //   //   _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   // ),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

showFutureDialog(
    {required BuildContext context, required Future<dynamic> future}) {
  print("I am in future dialog");
  showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                var response = snapshot.data as Response;
                return AlertDialog(
                  title: Text(response.code),
                  content: Text(response.message),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Okay"))
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      });
}

showFuturePoponSucessDialog(
    {required BuildContext context, required Future<dynamic> future}) {
  print("I am in future dialog");
  showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                var response = snapshot.data as Response;
                if (response.code == "success") {
                  Navigator.of(context).pop();
                }
                return AlertDialog(
                  title: Text(response.code),
                  content: Text(response.message),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Okay"))
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      });
}

showFutureCustomDialog(
    {required BuildContext context,
    required Future<dynamic> future,
    required void Function()? onTapOk}) {
  showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                var response = snapshot.data as Response;
                if (response.code == "success") {
                  Navigator.of(context).pop();
                }
                return AlertDialog(
                  title: Text(response.code),
                  content: Text(response.message),
                  actions: [
                    ElevatedButton(
                        onPressed: response.code == "Error"
                            ? () {
                                Navigator.of(context).pop();
                              }
                            : onTapOk,
                        child: const Text("Okay"))
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      });
}

class CustomDropDownFormField extends StatelessWidget {
  const CustomDropDownFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.onTap,
    this.leftPad = 20,
    required this.selectedValue,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final Object? selectedValue;

  final void Function(Object?)? onChanged;
  final void Function()? onTap;
  final double? leftPad;

  final List<DropdownMenuItem<Object>>? items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, leftPad!, 16),
      child: DropdownButtonFormField(
        isExpanded: false,
        value: selectedValue,
        onChanged: onChanged,
        onTap: onTap,
        decoration: InputDecoration(
          constraints: const BoxConstraints.expand(height: 65),
          labelText: labelText,
          labelStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: const Color(0xFFEF4C43),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: const Color(0xFF95A1AC),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
        ),
        style: const TextStyle(
          fontFamily: 'Lexend Deca',
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        items: items,
      ),
    );
  }
}

var inputDecoration = InputDecoration(
  // labelText: labelText,
  labelStyle: const TextStyle(
    fontFamily: 'Lexend Deca',
    color: Color(0xFFEF4C43),
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
  // hintText: hintText,
  hintStyle: const TextStyle(
    fontFamily: 'Lexend Deca',
    color: Color(0xFF95A1AC),
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFFDBE2E7),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFFDBE2E7),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
  // prefixIcon: prefixIcon,
);
