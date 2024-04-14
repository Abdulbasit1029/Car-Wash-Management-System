import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'API Practice',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _fetchData() async {
    // API URL
    const String url = 'https://jsonplaceholder.typicode.com/todos/1';
    // const String url = 'https://jsonplaceholder.typicode.com/posts';
    // Fetch the data
    final Response response = await get(Uri.parse(url));
    // Decode the response
    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    // Set the state
    setState(() {
      _data = data;
    });
    print(data);
  }

  Map<String, dynamic> _data = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Practice'),
        actions: [
          IconButton(
            onPressed: () {
              // Call the API
              _fetchData();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'API Data',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              _data.toString(),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// Model class for the data
class Post {
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
