import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_blog/domain/domain.dart';
import 'package:simple_blog/service/service.dart';
import 'package:simple_blog/widgets/widgets.dart';

class PostScreen extends StatefulWidget {
  PostScreen({this.postId});

  final int postId;

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PostScreenModel _model;

  @override
  void initState() {
    super.initState();

    final persistent = Provider.of<Persistent>(context, listen: false);
    final persistKey = 'post-screen-model[${widget.postId}]}';

    try {
      _model = persistent.fetch<PostScreenModel>(persistKey);
    } catch (e) {
      _model = PostScreenModel(
        blogRepository: Provider.of<BlogRepository>(context, listen: false),
      );
      _model.loadPost(widget.postId);
      _model.loadComments(widget.postId);

      persistent.persist(persistKey, _model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Scaffold(
        body: Consumer<PostScreenModel>(
          builder: (context, value, child) {
            if (value.post == null) {
              return LoadingWidget();
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  title: Text(value.post.title),
                ),
                SliverToBoxAdapter(child: _image(context, value.post)),
                SliverToBoxAdapter(child: _body(context, value.post)),
                SliverToBoxAdapter(child: _commentListHeader(context)),
                PostCommentListWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _commentListHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        'Комментарии',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _image(BuildContext context, PostEntity post) {
    return Stack(
      children: [
        DummyImageWidget(),
        Positioned(
          bottom: 15,
          right: 15,
          child: Text(post.title),
        ),
      ],
    );
  }

  Widget _body(BuildContext context, PostEntity post) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(post.body),
    );
  }
}

class PostCommentListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostScreenModel>(
      builder: (context, value, child) {
        if (value.comments != null) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _PostScreenCommentWidget(comment: value.comments[index]);
              },
              childCount: value.comments.length,
            ),
          );
        }

        return SliverFillRemaining(child: LoadingWidget());
      },
    );
  }
}

class _PostScreenCommentWidget extends StatelessWidget {
  _PostScreenCommentWidget({@required this.comment});

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment.body),
      subtitle: Text(comment.email),
    );
  }
}
