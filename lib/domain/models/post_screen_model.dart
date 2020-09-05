import 'package:flutter/foundation.dart';
import 'package:simple_blog/domain/domain.dart';
import 'package:simple_blog/service/service.dart';

class PostScreenModel extends ChangeNotifier {
  PostScreenModel({@required BlogRepository blogRepository})
      : _blogRepository = blogRepository;

  final BlogRepository _blogRepository;

  PostEntity post;
  List<CommentEntity> comments;

  Future<void> loadPost(int id) async {
    post = await _blogRepository.post(id);

    notifyListeners();
  }

  Future<void> loadComments(int id) async {
    comments = await _blogRepository.commentList(id);

    notifyListeners();
  }
}
