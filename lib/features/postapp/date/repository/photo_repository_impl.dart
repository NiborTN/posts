import 'package:posts/features/postapp/domain/entities/photo.dart';
import 'package:posts/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts/features/postapp/domain/repositories/photo_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/photo_local_data_source.dart';
import '../datasources/photo_remote_data_source.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource remoteDataSource;
  final PhotoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PhotoRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Faliure, List<Photo>>> getPhotoList(int albumId) async {
    if (await networkInfo.isConnected) {
      try {
        final photo = await remoteDataSource.getPhotoList(albumId);
        localDataSource.cachePhotoList(photo);
        return Right(photo);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      try {
        final localPhoto = await localDataSource.getLastPhotoList();
        return Right(localPhoto);
      } on CacheException {
        return Left(CacheFaliure());
      }
    }
  }
}
