import 'package:flutter/material.dart';
import 'package:posts/post.dart';
import 'package:posts/state/post_provider.dart';
import 'package:posts/utils/loader.dart';
import 'package:provider/provider.dart';

// class AddEditPostScreenArguments {
//   final Post post;
//   AddEditPostScreenArguments(this.post);
// }

class AddEditPostScreen extends StatefulWidget {
  const AddEditPostScreen({Key? key}) : super(key: key);

  static const routeName = "/addEditPostScreen";

  @override
  State<AddEditPostScreen> createState() => _AddEditPostScreenState();
}

class _AddEditPostScreenState extends State<AddEditPostScreen> {
  final title = TextEditingController();
  final body = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void clearTextFields() {
    title.text = "";
    body.text = "";
  }

  void onCreatePostClick(Post? post) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (mounted) {
      LoaderUtil(context).startLoading();
    }
    if (post != null) {
      await Provider.of<PostProvider>(context, listen: false).updatePost(Post(
          id: post.id,
          userId: post.userId,
          title: title.text,
          body: body.text));
    } else {
      await Provider.of<PostProvider>(context, listen: false)
          .createPost(
              Post(id: 0, userId: 1, title: title.text, body: body.text))
          .catchError((error) {
        debugPrint('$error');
      });
    }
    if (mounted) {
      LoaderUtil(context).stopLoading();
    }

    clearTextFields();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  String? validate(value) {
    if (value!.isEmpty) return "Field should not be empty.";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Post? post;
    final postData = ModalRoute.of(context)?.settings.arguments;
    if (postData != null && postData is Post) {
      title.text = postData.title;
      body.text = postData.body;
      post = postData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(post != null ? "Edit Post" : "Add Post"),
      ),
      body: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            margin: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              children: [
                TextFormField(
                    controller: title,
                    validator: validate,
                    decoration: const InputDecoration(labelText: "Title")),
                TextFormField(
                  controller: body,
                  validator: validate,
                  decoration: const InputDecoration(labelText: "Body"),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: ElevatedButton(
                    onPressed: () => onCreatePostClick(post),
                    child: post != null
                        ? const Text("Edit Post")
                        : const Text("Create Post"),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
