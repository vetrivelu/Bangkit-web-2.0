// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs, unused_field

import 'dart:async';
import 'dart:io';

import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/profile/profileregistration.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewer extends StatefulWidget {
  const WebViewer({Key? key, this.url}) : super(key: key);

  @override
  _WebViewerState createState() => _WebViewerState();
  final String? url;
}

class _WebViewerState extends State<WebViewer> {
  final Completer<WebViewController>? _webViewController = Completer<WebViewController>();
  WebViewController? _controller;

  var _selectedState = links.links!.keys.last;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: SizedBox(height: getHeight(context) * 0.15, child: Image.asset('assets/bina.png')),
          ),
          // backgroundColor: Colors.green,
          body: Column(
            children: [
              CustomDropDownButtonformField(
                value: _selectedState,
                onChanged: (p0) {
                  setState(() {
                    _selectedState = p0!;
                    links.refresh();
                  });
                  if (_controller != null) {
                    _controller!.loadUrl(links.links![_selectedState]);
                    setState(() {
                      isLoading = true;
                    });
                  }
                  // _webViewController!.future.then((value) => value.loadUrl(links.links![_selectedState]));
                },
                item: links.links!.keys
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
              ),
              Expanded(
                child: Builder(builder: (BuildContext context) {
                  return Stack(
                    children: [
                      WebView(
                        onPageFinished: (url) {
                          print(url);
                          setState(() {
                            isLoading = false;
                          });
                          // Navigator.of(context).pop();
                        },
                        // onPageStarted: (url) => sh),
                        initialUrl: widget.url ?? links.links![_selectedState] ?? "www.pagenotfound.com",
                        backgroundColor: Colors.white,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (controller) {
                          _webViewController!.complete(controller);
                          _controller = controller;
                        },
                      ),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Stack(),
                    ],
                  );
                }),
              ),
            ],
          )),
    );
  }
}
