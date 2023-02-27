// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:posts/features/postapp/domain/entities/photo.dart';
import 'package:posts/features/postapp/presentation/bloc/photo_bloc/photo_bloc_export.dart';

class PhotoCustomScrollView extends StatelessWidget {
  final List<Photo> photoList;
  final String albumTitle;
  final Photo bigImage;
  const PhotoCustomScrollView({
    Key? key,
    required this.photoList,
    required this.albumTitle,
    required this.bigImage,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          floating: true,
          pinned: true,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Image.network(bigImage.image, fit: BoxFit.cover),
          ),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return InkWell(
              child: CachedNetworkImage(
                imageUrl: photoList[index].image,
              ),
              onTap: () {
                context.read<PhotoBloc>().add(
                      ChangePhoto(photoList[index]),
                    );
              },
            );
          }, childCount: photoList.length),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100.0,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 1.0,
          ),
        )
      ],
    );
  }
}
