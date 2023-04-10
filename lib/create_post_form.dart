import 'package:flutter/material.dart';

class CreatePostForm extends StatefulWidget {
  const CreatePostForm({Key? key, required this.onCreatePost})
      : super(key: key);

  final Function(Map<String, dynamic>, Function()) onCreatePost;

  @override
  State<CreatePostForm> createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {
  final title = TextEditingController();
  final body = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void clearTextFields() {
    title.text = "";
    body.text = "";
  }

  void onCreatePostClick() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    widget.onCreatePost({
      "title": title.text,
      "body": body.text,
      "userId": 1, // static for this demo
    }, clearTextFields);
  }

  String? validate(value) {
    if (value!.isEmpty) return "Field should not be empty.";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  onPressed: onCreatePostClick,
                  child: const Text("Create Post"),
                ),
              )
            ],
          ),
        ));
  }
}
