import 'package:dio/dio.dart';
import 'package:posts/post.dart';

import '../api_routes.dart';
import '../models/posts.dart';

class PostService {
  var dio = Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  Future<Post> postPost(Post post) async {
    var response = await dio.post<Map<String, dynamic>>(APIRoutes.post,
        data: post.toJson());
    var postToSet = Post.fromJson(response.data!);
    return Future.value(postToSet);
  }

  Future<List<Post>> getPosts() async {
    var response = await dio.get(APIRoutes.post);
    if (response.statusCode == 200) {
      var postData = Posts.fromJson(response.data);
      return Future.value(postData.posts);
    }
    return [];
  }

  Future<bool> putPost(Post post) async {
    var response = await dio.put('${APIRoutes.post}/${post.id}');
    if (response.statusCode == 200) {
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> deletePost(int postId) async {
    var response = await dio.delete('${APIRoutes.post}/$postId');
    if (response.statusCode == 200) {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
