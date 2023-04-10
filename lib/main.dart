import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:posts/api_routes.dart';
import 'package:posts/create_post_form.dart';
import 'package:posts/models/posts.dart';
import 'package:posts/post.dart';
import 'package:posts/post_list_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isScreenLoading = false;
  List<Post> postList = [];
  void setScreenLoading(bool value) {
    setState(() {
      isScreenLoading = value;
    });
  }

  void fetchPosts() async {
    setScreenLoading(true);
    var dio = Dio();
    var response = await dio.get(APIRoutes.post);
    var postData = Posts.fromJson(response.data);
    postList.addAll(postData.posts);
    setState(() {});
    setScreenLoading(false);
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void onCreatePostClick(
      Map<String, dynamic> reqObject, Function() clearTextFields) async {
    var dio = Dio();
    var response = await dio.post(APIRoutes.post, data: reqObject);
    var postData = Post.fromJson(response.data);
    postList.insert(0, postData);
    setState(() {});
    clearTextFields();
  }

  void onEditClick(String title, String body) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Posts App",
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              CreatePostForm(onCreatePost: onCreatePostClick),
              isScreenLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            return PostListItem(
                              title: postList[index].title,
                              body: postList[index].body,
                              onEditClick: () {
                                print("Edit icon clicked");
                              },
                              onDeleteClick: () {
                                setState(() {
                                  postList.removeAt(index);
                                });
                              },
                            );
                          }),
                    ),
            ],
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
