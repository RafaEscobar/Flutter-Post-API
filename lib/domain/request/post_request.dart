import 'package:dio/dio.dart';
import 'package:dio_practice/domain/helpers/post_helper.dart';
import 'package:dio_practice/domain/models/post.dart';

class PostRequest {
  static final _dio = Dio();

  static Future<List<Post>> get() async {
    final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
    final res = (response.data as List)
        .map((map) => PostHelper.fromJson(map).toPostEntity())
        .toList();
    return res;
  }
}