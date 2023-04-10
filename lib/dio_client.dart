import 'package:dio/dio.dart';
import 'package:posts/post.dart';

class DioClient {
  final Dio dio = Dio();

  final baseUrl = 'https://jsonplaceholder.typicode.com';

  // Future<Post> getAllPosts() async {
  //   Response postData = await dio.get(baseUrl + "/posts");
  // }
}
