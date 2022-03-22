import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../constants/themeconstants.dart';

class NullImage extends StatelessWidget {
  const NullImage({
    Key? key,
    this.onTap,
    this.icon,
  }) : super(key: key);
  final void Function()? onTap;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.all(12),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.05,
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: icon ??
                const Icon(
                  Icons.add_a_photo,
                  // color: FlutterFlowTheme.primaryColor,
                  size: 24,
                ),
          ),
        ),
      ),
    );
  }
}

class FileImage extends StatelessWidget {
  const FileImage({
    Key? key,
    required this.image,
    this.onTap,
  }) : super(key: key);
  final Uint8List image;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.05,
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.memory(image),
            ),
            Positioned(
              top: 1,
              right: 1,
              child: GestureDetector(
                  onTap: onTap, child: const Icon(Icons.cancel)),
            )
          ],
        ),
      ),
    );
  }
}

class FileWidget extends StatelessWidget {
  const FileWidget({
    Key? key,
    this.onTap,
    required this.name,
  }) : super(key: key);
  final String name;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.05,
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            AspectRatio(
                aspectRatio: 1,
                child: Column(
                  children: [
                    const Icon(Icons.file_copy),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(name),
                    )
                  ],
                )),
            Positioned(
              top: 1,
              right: 1,
              child: GestureDetector(
                  onTap: onTap, child: const Icon(Icons.cancel)),
            )
          ],
        ),
      ),
    );
  }
}

class NetworkImage extends StatelessWidget {
  const NetworkImage({
    Key? key,
    required this.url,
    this.onTap,
  }) : super(key: key);
  final String url;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.05,
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(url),
            ),
            Positioned(
              top: 1,
              right: 1,
              child: GestureDetector(
                  onTap: onTap, child: const Icon(Icons.cancel)),
            )
          ],
        ),
      ),
    );
  }
}
