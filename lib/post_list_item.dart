import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  final String title;
  final String body;
  final Function() onEditClick;
  final Function() onDeleteClick;

  const PostListItem(
      {super.key,
      required this.title,
      required this.body,
      required this.onEditClick,
      required this.onDeleteClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 20),
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: onEditClick,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 2,
              ),
              IconButton(
                  onPressed: onDeleteClick,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
