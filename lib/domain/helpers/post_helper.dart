import 'package:dio_practice/domain/models/post.dart';

class PostHelper {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostHelper({
    required this.userId,
    required this.id,
    required this.title,
    required this.body
  });

  factory PostHelper.fromJson( Map<String, dynamic> json ) => PostHelper(
    userId: json['userId'],
    id: json['id'],
    title: json['title'],
    body: json['body']
  );

  Post toPostEntity() => Post(
    body: body,
    id: id,
    title: title
  );
}