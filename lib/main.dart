import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_blog/screens/screens.dart';
import 'package:simple_blog/service/blog_repository.dart';

void main() {
  Widget app = SimpleBlogApplication();

  app = MultiProvider(
    providers: [
      Provider(
        create: (context) => BlogRepository(
          baseUrl: 'https://jsonplaceholder.typicode.com/',
        ),
      ),
    ],
    child: app,
  );

  runApp(app);
}

class SimpleBlogApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Blog Application',
      home: PostListScreen(),
    );
  }
}
