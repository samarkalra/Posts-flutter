import 'package:flutter/material.dart';
import 'package:posts/services/post_services.dart';
import '../post.dart';

class PostProvider with ChangeNotifier {
  final List<Post> _posts = [];
  bool isListLoading = false;
  final PostService service;

  List<Post> get postList => _posts;

  PostProvider({required this.service});

  void setPosts(List<Post> posts) {
    if (_posts.isNotEmpty) {
      _posts.clear();
    }
    _posts.addAll(posts);
    notifyListeners();
  }

  void setIsListLoading(bool isLoading) {
    isListLoading = isLoading;
    notifyListeners();
  }

  Future<void> createPost(Post post) async {
    setIsListLoading(true);

    try {
      var response = await service.postPost(post);
      var postToSet = response;
      _posts.insert(0, postToSet);
      setIsListLoading(false);
    } catch (error) {
      setIsListLoading(false);
    }
  }

  void readPosts() async {
    setIsListLoading(true);

    final response = await service.getPosts();
    _posts.addAll(response);

    setIsListLoading(false);
  }

  Future<void> updatePost(Post post) async {
    setIsListLoading(true);

    try {
      var response = await service.putPost(post);
      if (response) {
        var postIndex = _posts.indexWhere((element) => element.id == post.id);
        _posts.removeAt(postIndex);
        _posts.insert(postIndex, post);
        setIsListLoading(false);
      }
    } catch (error) {
      setIsListLoading(false);
    }
  }

  Future<void> deletePost(int postId) async {
    setIsListLoading(true);

    try {
      var response = await service.deletePost(postId);
      if (response) {
        _posts.removeWhere((element) => element.id == postId);
        setIsListLoading(false);
      }
    } catch (error) {
      setIsListLoading(false);
    }
    notifyListeners();
  }
}
