import 'package:dio_practice/domain/providers/post_provider.dart';
import 'package:dio_practice/screens/screen_one.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenOne(),
      ),
    );
  }
}