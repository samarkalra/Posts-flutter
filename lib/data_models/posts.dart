import 'package:json_annotation/json_annotation.dart';
import '../post.dart';

part 'posts.g.dart';

@JsonSerializable()
class Posts {
  List<Post> posts;

  Posts({this.posts = const []});

  factory Posts.fromJson(List<dynamic> json) => _$PostsFromJson(json);
  List<dynamic> toJson() => _$PostsToJson(this);
}
