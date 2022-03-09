import 'package:flutter/material.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({Key? key, this.urls}) : super(key: key);

  final List<String>? urls;

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  void initState() {
    super.initState();
    urls = widget.urls ?? ["https://picsum.photos/536/354", "https://picsum.photos/536/355"];
  }

  get children => urls.map((url) => Center(child: Image.network(url))).toList();

  late List<String> urls;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Row(children: [
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () {
                setState(() {
                  selectedIndex = ((selectedIndex - 1) % urls.length);
                  print(selectedIndex);
                });
              },
              icon: const Icon(
                Icons.arrow_left,
                color: Colors.grey,
                size: 60,
              )),
        ),
        Expanded(
            flex: 12,
            child: IndexedStack(
              index: selectedIndex,
              children: children,
            )),
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () {
                setState(() {
                  selectedIndex = ((selectedIndex + 1) % urls.length);
                  print(selectedIndex);
                });
              },
              icon: const Icon(
                Icons.arrow_right,
                color: Colors.grey,
                size: 60,
              )),
        ),
      ]),
    );
  }
}
