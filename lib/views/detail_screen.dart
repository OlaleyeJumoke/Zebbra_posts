import 'package:flutter/material.dart';
import 'package:zebrra_posts/model/post_model.dart';
import 'package:zebrra_posts/repository/posts_repository.dart';
import 'package:zebrra_posts/utils/colors.dart';

class Detail extends StatefulWidget {
  Detail({Key? key, this.postId = ""}) : super(key: key);
  String postId;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var future;
  @override
  void initState() {
    future = Requests().getPostDetails(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColor.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Post Detail",
            style: TextStyle(color: CustomColor.white),
          ),
        ),
        backgroundColor: CustomColor.lightGrey,
        body: SafeArea(
            child: FutureBuilder<PostModel>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            "Error loading data, please check your \ninternet connection..."));
                  } else if (snapshot.hasData) {
                    PostModel? data = snapshot.data;
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 20),
                        decoration: BoxDecoration(
                            color: CustomColor.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        //height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              data!.title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              data.body!,
                              style: TextStyle(
                                  color: CustomColor.blue,
                                  decoration: TextDecoration.underline),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(data.body!),
                          ],
                        ));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })) //,
        );
  }
}
