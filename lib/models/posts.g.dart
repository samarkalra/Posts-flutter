// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Posts _$PostsFromJson(List<dynamic> json) => Posts(
      posts: (json)
              ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

List<Map<String,dynamic>> _$PostsToJson(Posts instance) =>
    instance.posts.map((e) => e.toJson()).toList();
