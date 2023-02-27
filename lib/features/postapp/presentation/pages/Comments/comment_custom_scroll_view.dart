import 'package:flutter/material.dart';
import 'package:posts/features/postapp/domain/entities/comment.dart';

import '../../../domain/entities/posts.dart';

class CommentCustomScrollView extends StatelessWidget {
  final List<Comments> commentList;
  final Post post;
  const CommentCustomScrollView({
    super.key,
    required this.post,
    required this.commentList,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 150.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(post.title),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                const SizedBox(height: 5),
                ListTile(
                  title: Text(commentList[index].name),
                  subtitle: Text(commentList[index].body),
                ),
                const SizedBox(height: 5),
                const Divider(
                  height: 1,
                  color: Colors.black87,
                )
              ],
            );
          }, childCount: commentList.length),
        )
      ],
    );
  }
}

class Comment {}
