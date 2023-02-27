// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posts/features/postapp/presentation/pages/Comments/comment_page.dart';

import '../../../domain/entities/posts.dart';

class PostListView extends StatelessWidget {
  List<Post> postList;
  PostListView({
    Key? key,
    required this.postList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: postList.length,
      itemBuilder: (context, index) {
        final post = postList[index];
        return Card(
          child: ListTile(
            tileColor: Colors.orange.shade100,
            textColor: Colors.blue,
            title: Text(post.title),
            subtitle: Text(
              post.body,
              textScaleFactor: 1,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CommentPage(
                            post: post,
                          )));
            },
          ),
        );
      },
    );
  }
}
