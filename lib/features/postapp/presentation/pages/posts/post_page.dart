import 'package:flutter/material.dart';
import 'package:posts/features/postapp/presentation/bloc/post_bloc/post_bloc_export.dart';
import 'package:posts/features/postapp/presentation/pages/posts/post_list_view.dart';

import '../../../../../injection_container.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocProvider<PostBloc>(
        create: (_) => sl.get<PostBloc>()..add(LoadPost()),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              return PostListView(postList: state.postList);
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
          },
        ),
      ),
    );
  }
}
