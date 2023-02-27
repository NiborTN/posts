import 'package:flutter/material.dart';
import 'package:posts/features/postapp/presentation/bloc/comment_bloc/comment_bloc_export.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/posts.dart';
import 'comment_custom_scroll_view.dart';

class CommentPage extends StatelessWidget {
  final Post post;
  const CommentPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CommentBloc>(
        create: (_) => sl.get<CommentBloc>()..add(LoadComment(postId: post.id)),
        child:
            BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
          if (state is CommentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CommentLoaded) {
            return CommentCustomScrollView(
              post: post,
              commentList: state.commentList,
            );
          } else if (state is Error) {
            return Center(
              child: Text(state.message, textDirection: TextDirection.ltr),
            );
          } else {
            return const Center(
              child: Text('something went wrong',
                  textDirection: TextDirection.ltr),
            );
          }
        }),
      ),
    );
  }
}
