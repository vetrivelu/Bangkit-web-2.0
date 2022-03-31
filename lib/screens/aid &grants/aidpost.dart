import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/aid_and_grant.dart';
import 'package:bangkit/screens/aid%20&grants/aidstory.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../web/post_form.dart';

class AidAndGrants extends StatefulWidget {
  const AidAndGrants({Key? key}) : super(key: key);

  @override
  _AidAndGrantsState createState() => _AidAndGrantsState();
}

class _AidAndGrantsState extends State<AidAndGrants> {
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => PostForm());
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: SizedBox(height: getHeight(context) * 0.15, child: Image.asset('assets/bina.png')),
          // bottom: PreferredSize(child: child, preferredSize: preferredSize),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              setState(() {});
              return Future.delayed(const Duration(seconds: 1));
            },
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: posts.orderBy("created", descending: true).snapshots(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        List<Post> tempPosts = snapshot.data!.docs.map((e) => Post.fromJson(e.data())).toList();
                        return Column(
                          children: tempPosts.map((e) {
                            return PostTile(post: e);
                          }).toList(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text("Error Occured"));
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class PostTile extends StatefulWidget {
  PostTile({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  get averageRating {
    if (widget.post.totalRaters == 0) {
      return 0.0;
    }
    print("==============>     ${widget.post.totalRating}");
    return (widget.post.totalRating * 1.0) / (widget.post.totalRaters * 1.0).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => Story(post: widget.post));
              },
              child: Column(
                children: [
                  ListTile(
                    leading: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Get.to(() => PostForm(post: widget.post));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              widget.post.deletePost();
                            },
                          ),
                        ],
                      ),
                    ),
                    title: Text(widget.post.name),
                    subtitle: Text(
                      widget.post.state,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    trailing: FutureBuilder<dynamic>(
                        future: widget.post.loadRatings(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
                            return RatingBarIndicator(
                              rating: averageRating,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 26.0,
                              unratedColor: Colors.amber.withAlpha(50),
                              direction: Axis.horizontal,
                            );
                          }
                          if (snapshot.hasError) {
                            const Text("Error Loading Ratings");
                          }
                          return RatingBarIndicator(
                            rating: 0,
                            itemSize: 26.0,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          );
                        }),
                  ),
                  (widget.post.media ?? []).isNotEmpty ? Image.network(widget.post.media![0]) : Container(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.post.title,
                      style: getText(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
