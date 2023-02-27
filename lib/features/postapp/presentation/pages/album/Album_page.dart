import 'package:flutter/material.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/album.dart';
import '../../bloc/album_bloc/album_bloc_export.dart';
import 'album_list_view.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Albums'),
        ),
        body: BlocProvider<AlbumBloc>(
          create: (_) => sl.get<AlbumBloc>()..add(LoadAlbum()),
          child: BlocBuilder<AlbumBloc, AlbumState>(
            builder: (context, state) {
              if (state is AlbumLoading) {
                return const CircularProgressIndicator();
              } else if (state is AlbumLoaded) {
                return AlbumListVeiw(
                  albumList: state.albumList,
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
            },
          ),
        ));
  }
}
