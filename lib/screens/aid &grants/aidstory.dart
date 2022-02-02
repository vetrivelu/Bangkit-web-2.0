import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/aid_and_grant.dart';
import 'package:bangkit/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Story extends StatefulWidget {
  const Story({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  bool isUseful = false;

  Widget getAttachmentTile(url) {
    return GestureDetector(
      onTap: () async {
        await launch(url);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey,
          ),
          child: const AspectRatio(
            aspectRatio: 1,
            child: Icon(
              Icons.attach_file,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget getImageTile(url) {
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) {
              return PhotoView(imageProvider: NetworkImage(url));
            });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(url, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }

  Widget listOfDetails(title, icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF00b3df),
      ),
      title: Text(
        title,
        style: getText(context).subtitle2,
      ),
    );
  }

  List<String> get attachments => widget.post.attachments ?? [];
  List<String> get videos => widget.post.videos ?? [];
  List<String> get media => widget.post.media ?? [];

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Column Widget...
        SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: SizedBox(height: getHeight(context) * 0.15, child: Image.asset('assets/bina.png')),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 20, 24, 0),
                      child: Text(
                        widget.post.title,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        softWrap: true,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF090F13),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                              child: Text(
                                widget.post.description,
                                style: const TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF8B97A2),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    media.isEmpty ? Container() : MediaLister(type: FileType.image, urls: widget.post.media ?? []),
                    videos.isEmpty ? Container() : MediaLister(type: FileType.video, urls: widget.post.videos ?? []),
                    attachments.isEmpty ? Container() : MediaLister(type: FileType.attachment, urls: widget.post.attachments ?? []),
                    const SizedBox(
                      height: 20,
                    ),
                    listOfDetails(widget.post.address, Icons.location_pin),
                    listOfDetails(widget.post.name, Icons.person),
                    listOfDetails(widget.post.phone, Icons.phone),
                    listOfDetails(widget.post.email, Icons.mail),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("Average rating"),
                    ),
                    RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: widget.post.totalRating / widget.post.totalRaters,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    SizedBox(
                      height: getHeight(context) * 0.1,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaLister extends StatelessWidget {
  const MediaLister({Key? key, required this.type, required this.urls}) : super(key: key);

  final FileType type;
  final List<String> urls;

  static const _array = ["Images", "Videos", "Attachments"];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Text(
            _array[type.index],
            style: Theme.of(context).textTheme.headline6!.merge(const TextStyle(
                  shadows: [Shadow(color: Colors.black, offset: Offset(0, -5))],
                  color: Colors.transparent,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF22A8E0),
                  decorationThickness: 3,
                  decorationStyle: TextDecorationStyle.solid,
                )),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: urls.isEmpty ? const [Text("No files found")] : urls.map((e) => getTile(e, context)).toList(),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget getTile(urls, context) {
    switch (type) {
      case FileType.image:
        return getImageTile(urls, context);
      case FileType.video:
        return getVideoTile(urls, context);
      case FileType.attachment:
        return getAttachmentTile(urls, context);
    }
  }

  Widget getImageTile(url, context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return PhotoView(imageProvider: NetworkImage(url));
            });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(url, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }

  Widget getVideoTile(urls, context) {
    var id;

    if (urls.toString().contains("=")) {
      id = urls.toString().split("=").last;
    } else {
      id = urls.toString().split("/").last;
    }

    var url = "https://img.youtube.com/vi/$id/0.jpg";
    return GestureDetector(
      onTap: () {
        Get.to(() => YouTube(id: id));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey,
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.contain, scale: 0.5),
          ),
          child: Icon(
            Icons.play_arrow,
            size: 30,
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }

  Widget getAttachmentTile(url, [context]) {
    return GestureDetector(
      onTap: () async {
        await launch(url);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey,
          ),
          child: const AspectRatio(
            aspectRatio: 1,
            child: Icon(
              Icons.attach_file,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class YouTube extends StatefulWidget {
  const YouTube({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<YouTube> createState() => _YouTubeState();
}

class _YouTubeState extends State<YouTube> {
  bool mute = true;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: mute,
      ),
    );
  }

  Widget getMuteIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          mute = !mute;
        });
        if (mute) {
          _controller.mute();
        } else {
          _controller.unMute();
        }
      },
      child: mute ? const Icon(Icons.volume_off) : const Icon(Icons.volume_up),
    );
  }

  late YoutubePlayerController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          width: getWidth(context),
          bottomActions: [
            CurrentPosition(),
            ProgressBar(isExpanded: true),
            getMuteIcon(),
          ],
        ),
      ),
    );
  }
}

enum FileType { image, video, attachment }
