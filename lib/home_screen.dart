import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:posts/add_edit_post_screen.dart';
import 'package:posts/post.dart';
import 'package:posts/post_list_item.dart';
import 'package:posts/state/post_provider.dart';
import 'package:posts/utils/loader.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostProvider>(context, listen: false).readPosts();
    });
  }

  void onAddClick() {
    Navigator.pushNamed(context, AddEditPostScreen.routeName);
  }

  void onEditClick(Post post) {
    Navigator.pushNamed(context, AddEditPostScreen.routeName, arguments: post);
  }

  void onDeleteClick(int postId) async {
    if (mounted) {
      LoaderUtil(context).startLoading();
    }
    await Provider.of<PostProvider>(context, listen: false).deletePost(postId);
    if (mounted) {
      LoaderUtil(context).stopLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    var posts = Provider.of<PostProvider>(context).postList;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Posts App",
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: onAddClick, icon: const Icon(Icons.add))
          ],
        ),
        body: posts.isEmpty
            ? Container()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostListItem(
                    title: posts[index].title,
                    body: posts[index].body,
                    onEditClick: () => onEditClick(posts[index]),
                    onDeleteClick: () => onDeleteClick(posts[index].id),
                  );
                }));
  }
}
