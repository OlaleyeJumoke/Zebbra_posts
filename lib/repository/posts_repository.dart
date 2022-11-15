import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zebrra_posts/model/post_model.dart';

var postsUrl = Uri.parse('https://jsonplaceholder.typicode.com/posts');
Uri postDetailUrl(String userId) =>
    Uri.parse('https://jsonplaceholder.typicode.com/posts/$userId');

class Requests {
  Future<List<PostModel>> getPosts() async {
    var response = await http.get(postsUrl);
    var decoded = jsonDecode(response.body);
    var data = List<PostModel>.from(decoded.map(
      (post) => PostModel.fromJson(
        post,
      ),
    ));
    return data;
  }

  Future<PostModel> getPostDetails(String postId) async {
    var response = await http.get(postDetailUrl(postId));
    var decoded = jsonDecode(response.body);
    var data = PostModel.fromJson(
      decoded,
    );
    return data;
  }
}
