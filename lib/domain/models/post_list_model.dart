import 'package:flutter/foundation.dart';
import 'package:simple_blog/domain/domain.dart';
import 'package:simple_blog/service/blog_repository.dart';

class PostListModel extends ChangeNotifier {
  PostListModel({@required this.repository});

  final BlogRepository repository;

  String error;
  List<PostEntity> posts;

  bool hasReachedMax = false;

  Future<void> loadPosts() async {
    try {
      final postList = await repository.listPosts();

      posts = postList;
      notifyListeners();
    } catch (e) {
      error = '$e';
      notifyListeners();
    }
  }

  Future<void> loadPostsNext() async {
    if (posts == null) {
      print(
          'Попытка подгрузки постов, когда ещё не был загружен изначальный список');
      return;
    }

    final postList = await repository.listPosts(offset: posts.length);
    // 5 - limit
    if (postList.length < 5) {
      hasReachedMax = true;
    }

    posts.addAll(postList);

    notifyListeners();
  }
}
