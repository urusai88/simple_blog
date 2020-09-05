import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:simple_blog/domain/domain.dart';
import 'package:simple_blog/domain/entities/comment_entity.dart';

class BlogRepository {
  BlogRepository({@required String baseUrl})
      : assert(baseUrl != null),
        _httpClient = http.Client(),
        _baseUrl = baseUrl.endsWith('/')
            ? baseUrl.substring(0, baseUrl.length - 1)
            : baseUrl;

  final String _baseUrl;
  final http.Client _httpClient;

  Future<List<PostEntity>> listPosts({int offset = 0}) async {
    final resp =
        await _httpClient.get('$_baseUrl/posts?_start=$offset&_limit=5');
    final json = (jsonDecode(resp.body) as List).cast<Map<String, dynamic>>();

    return json.map((e) => PostEntity.fromJson(e)).toList();
  }

  Future<PostEntity> post(int postId) async {
    final resp = await _httpClient.get('$_baseUrl/posts/$postId');
    final json = (jsonDecode(resp.body) as Map).cast<String, dynamic>();

    return PostEntity.fromJson(json);
  }

  Future<List<CommentEntity>> commentList(int postId) async {
    final resp = await _httpClient.get('$_baseUrl/comments?postId=$postId');
    final json = (jsonDecode(resp.body) as List).cast<Map<String, dynamic>>();

    return json.map((e) => CommentEntity.fromJson(e)).toList();
  }
}
