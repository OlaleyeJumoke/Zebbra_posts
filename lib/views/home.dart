import 'package:flutter/material.dart';
import 'package:zebrra_posts/model/post_model.dart';
import 'package:zebrra_posts/repository/posts_repository.dart';
import 'package:zebrra_posts/utils/colors.dart';
import 'package:zebrra_posts/views/detail_screen.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var future;
  @override
  void initState() {
    future = Requests().getPosts();
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
            "POSTS",
            style: TextStyle(color: CustomColor.white),
          ),
        ),
        backgroundColor: CustomColor.lightGrey,
        body: SafeArea(
            child: FutureBuilder<List<PostModel>>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            "Error loading data, please check your \ninternet connection..."));
                  } else if (snapshot.hasData) {
                    List<PostModel>? data = snapshot.data!.sublist(0, 99);
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (() {
                              print(data[index].id.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detail(
                                            postId: data[index].id.toString(),
                                          )));
                            }),
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                    color: CustomColor.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                //height: 300,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      data[index].title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      data[index].body!,
                                      style: TextStyle(
                                          color: CustomColor.blue,
                                          decoration: TextDecoration.underline),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(data[index].body!),
                                  ],
                                )),
                          );
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })) //,
        );
  }
}
