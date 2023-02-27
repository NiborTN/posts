import 'package:flutter/material.dart';

import '../../../domain/entities/album.dart';
import '../photo/photo_page.dart';

class AlbumListVeiw extends StatelessWidget {
  final List<Album> albumList;

  const AlbumListVeiw({
    super.key,
    required this.albumList,
  });

  @override
  Widget build(BuildContext context) {
    return albumListView();
  }

  ListView albumListView() {
    return ListView.builder(
        itemCount: albumList.length,
        itemBuilder: (BuildContext context, index) {
          final album = albumList[index];
          return Card(
            child: ListTile(
              tileColor: Colors.orange.shade100,
              textColor: Colors.blue,
              title: Text(album.title),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoPage(
                        album: album,
                      ),
                    ));
              },
            ),
          );
        });
  }
}
