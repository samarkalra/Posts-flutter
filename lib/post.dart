import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart'; // need to add this manually

@JsonSerializable()
class Post {
  int id;
  int userId;
  String title;
  String body;

  Post(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
