import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_blog/domain/domain.dart';
import 'package:simple_blog/screens/screens.dart';
import 'package:simple_blog/service/service.dart';
import 'package:simple_blog/widgets/widgets.dart';

typedef OnPostTapCallback = void Function(PostEntity post);

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  PostListModel model;

  @override
  void initState() {
    super.initState();

    model = PostListModel(
      blogRepository: Provider.of<BlogRepository>(context, listen: false),
    );
    model.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = ChangeNotifierProvider.value(
      value: model,
      child: Consumer<PostListModel>(
        builder: (context, value, child) {
          if (value.error != null) {
            return ErrorSimpleWidget(errorText: value.error);
          }

          if (value.posts != null) {
            return PostListWidget(posts: value.posts, onPostTap: _onPostTap);
          }

          return LoadingWidget();
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Список постов'),
      ),
      body: body,
    );
  }

  void _onPostTap(PostEntity post) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostScreen(postId: post.id),
      ),
    );
  }
}

class PostListWidget extends StatelessWidget {
  PostListWidget({
    @required this.posts,
    @required this.onPostTap,
  });

  final List<PostEntity> posts;
  final OnPostTapCallback onPostTap;

  @override
  Widget build(BuildContext context) {
    final hasReachedMax =
        Provider.of<PostListModel>(context, listen: false).hasReachedMax;

    return ListView.separated(
      itemCount: posts.length + (hasReachedMax ? 0 : 1),
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        if (posts.length > index) {
          return PostListItemWidget(post: posts[index], onTap: onPostTap);
        }

        Provider.of<PostListModel>(context, listen: false).loadPostsNext();

        return LoadingWidget();
      },
    );
  }
}

class PostListItemWidget extends StatelessWidget {
  PostListItemWidget({
    @required this.post,
    @required this.onTap,
  }) : assert(post != null);

  final PostEntity post;
  final OnPostTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => onTap(post),
          child: _image(context),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () => onTap(post),
                child: _title(context),
              ),
              SizedBox(height: 5),
              _body(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _image(BuildContext context) {
    return DummyImageWidget();
  }

  Widget _title(BuildContext context) {
    return Text(post.title, style: Theme.of(context).textTheme.headline5);
  }

  Widget _body(BuildContext context) {
    return Text(post.body, style: Theme.of(context).textTheme.bodyText2);
  }
}
