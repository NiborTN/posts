// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:posts/features/postapp/presentation/bloc/photo_bloc/photo_bloc_export.dart';
import 'package:posts/features/postapp/presentation/pages/photo/photo_custom_scroll_veiw.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/album.dart';

// ignore: must_be_immutable
class PhotoPage extends StatelessWidget {
  Album album;
  PhotoPage({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PhotoBloc>(
        create: (_) => sl.get<PhotoBloc>()..add(LoadPhoto(albumId: album.id)),
        child: BlocBuilder<PhotoBloc, PhotoState>(builder: (context, state) {
          if (state is PhotoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PhotoLoaded) {
            return PhotoCustomScrollView(
              photoList: state.photoList,
              albumTitle: album.title,
              bigImage: state.bigImage,
            );
          } else if (state is Error) {
            return Center(
              child: Text(state.message, textDirection: TextDirection.ltr),
            );
          } else {
            return const Text('something went wrong',
                textDirection: TextDirection.ltr);
          }
        }),
      ),
    );
  }
}
