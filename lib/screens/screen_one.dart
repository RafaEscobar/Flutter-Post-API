// import 'package:dio_practice/config/helpers/get_posts.dart';
import 'package:dio_practice/domain/models/post.dart';
import 'package:dio_practice/domain/request/post_request.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ScreenOne extends StatefulWidget{
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  List<Post>? posts;
  bool isLoaded = true;

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  Future<void> loadPosts() async {
    posts = await PostRequest.get();
    setState(() {
      isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entradas del día'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:   Body(isLoaded: isLoaded, posts: posts),
      )
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.isLoaded,
    required this.posts,
  });

  final bool isLoaded;
  final List<Post>? posts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return (isLoaded) ?
              const Skeletonizer.zone(
                child:  Skeletonizer(
                  enabled: true,
                  child : Column(
                    children: [
                      ContainerBox(
                        boxColor: Color.fromARGB(41, 33, 149, 243),
                      ),
                      SizedBox(height: 10,)
                    ],
                  )
                )
              ) :
              Column(
                children: [
                  ContainerBox(
                    boxColor: Colors.blue,
                    boxChild: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      child: Text(
                        'Valor: ${posts![index].title.substring(0, 12)}...',
                        style: const TextStyle(
                          color: Colors.white
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,)
                ],
              );
          },
        )
      );
  }
}

class ContainerBox extends StatelessWidget {
  const ContainerBox({
    super.key,
    required this.boxColor,
    this.boxChild,
  });

  final Color boxColor;
  final Widget? boxChild;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: boxColor,
      ),
      child: boxChild
    );
  }
}