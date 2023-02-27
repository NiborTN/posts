import 'package:dartz/dartz.dart';
import 'package:posts/features/postapp/domain/entities/posts.dart';

import '../../../../core/error/faliures.dart';
import '../entities/album.dart';

abstract class PostRepository {
  Future<Either<Faliure, List<Post>>> getPostList();
}
