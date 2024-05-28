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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entradas del día'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:   Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return (isLoaded) ?
                  Skeletonizer.zone(
                    child:  Skeletonizer(
                      enabled: true,
                      child : Column(
                        children: [
                          ContainerBox(
                            size: size,
                            boxColor: const Color.fromARGB(41, 33, 149, 243),
                          ),
                          const SizedBox(height: 10,)
                        ],
                      )
                    )
                  ) :
                  Column(
                    children: [
                      ContainerBox(
                        size: size,
                        boxColor: Colors.blue,
                        boxChild: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text('Valor: ${posts![index].title.substring(0, 12)}...', style: const TextStyle(color: Colors.white),),
                        ),
                        posts: posts,
                        index: index
                      ),
                      const SizedBox(height: 10,)
                    ],
                  );
              },
            )
          ),
      )
    );
  }
}

class ContainerBox extends StatelessWidget {
  const ContainerBox({
    super.key,
    required this.size,
    required this.boxColor,
    this.boxChild,
    this.posts,
    this.index,
  });

  final Size size;
  final Color boxColor;
  final List<Post>? posts;
  final int? index;
  final Widget? boxChild;

  @override
  Widget build(BuildContext context) {
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