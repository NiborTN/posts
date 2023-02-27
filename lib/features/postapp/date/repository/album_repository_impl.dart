import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/album_local_data_source.dart';
import '../datasources/album_remote_data_source.dart';
import '../../domain/entities/album.dart';
import '../../../../core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource remoteDataSource;
  final AlbumLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AlbumRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Faliure, List<Album>>> getAlbumList() async {
    if (await networkInfo.isConnected) {
      try {
        final album = await remoteDataSource.getAlbumList();
        localDataSource.cacheAlbumList(album);
        return Right(album);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      try {
        final localAlbum = await localDataSource.getLastAlbumList();
        return Right(localAlbum);
      } on CacheException {
        return Left(CacheFaliure());
      }
    }
  }
}
