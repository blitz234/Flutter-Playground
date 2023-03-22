import 'dart:convert';

import 'package:api/models/post_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<PostModel>> getPostApi() async {
    List<PostModel> postList = [];
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
              future: getPostApi(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  debugPrint("Loading");
                  return const Text("Loading");
                } else {
                  List<PostModel>? posts = snapshot.data;
                  return ListView.builder(
                      itemBuilder: ((context, index) {
                        return Text(posts![index].title.toString());
                      }),
                      itemCount: posts?.length);
                }
              })),
        )
      ]),
    );
  }
}
