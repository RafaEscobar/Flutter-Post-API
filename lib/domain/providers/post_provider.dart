import 'package:dio_practice/domain/request/post_request.dart';
import 'package:flutter/material.dart';

//! NO USADO DE MOMENTO
class PostProvider extends ChangeNotifier {
  List<dynamic>? posts;

  Future<void> getPosts() async {
    posts = await PostRequest.get();
  }
}