import 'package:dartz/dartz.dart';
import 'package:posts/features/postapp/domain/entities/photo.dart';

import '../../../../core/error/faliures.dart';

abstract class PhotoRepository {
  Future<Either<Faliure, List<Photo>>> getPhotoList(int albumId);
}
