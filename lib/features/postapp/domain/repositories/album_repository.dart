import 'package:dartz/dartz.dart';

import '../../../../core/error/faliures.dart';
import '../entities/album.dart';

abstract class AlbumRepository {
  Future<Either<Faliure, List<Album>>> getAlbumList();
}
