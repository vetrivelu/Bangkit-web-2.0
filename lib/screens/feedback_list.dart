import 'package:bangkit/constants/themeconstants.dart';
import 'package:bangkit/models/feedback.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:flutter/material.dart';

class FeedbackList extends StatelessWidget {
  const FeedbackList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: feedbacks.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // print("document length =========== ${snapshot.data!.docs.length}");
              return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var json = snapshot.data!.docs[index].data();
                    var feedback = MyFeedback.fromJson(json);
                    return Card(
                        child: Column(
                      children: [
                        ListTile(
                          title: Text(feedback.title),
                          subtitle: Text(feedback.description),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Text("Raised by : ${feedback.raisedBy}")),
                              Expanded(flex: 3, child: Text("Raised on : ${feedback.raiseddDate.toString().substring(0, 10)}")),
                              Expanded(flex: 10, child: Container()),
                            ],
                          ),
                        )
                      ],
                    ));
                  });
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
