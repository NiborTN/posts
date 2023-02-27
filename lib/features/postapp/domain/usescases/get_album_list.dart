import 'package:posts/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts/core/usescases/usecase.dart';
import 'package:posts/features/postapp/domain/entities/album.dart';
import 'package:posts/features/postapp/domain/repositories/album_repository.dart';

class GetAlbumList implements UseCase<List<Album>, NoParams> {
  final AlbumRepository repository;

  GetAlbumList(this.repository);

  @override
  Future<Either<Faliure, List<Album>>> call(NoParams params) async {
    return await repository.getAlbumList();
  }
}
