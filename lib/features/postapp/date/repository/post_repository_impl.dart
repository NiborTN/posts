import 'package:posts/features/postapp/domain/entities/posts.dart';
import 'package:posts/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts/features/postapp/domain/repositories/post_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Faliure, List<Post>>> getPostList() async {
    if (await networkInfo.isConnected) {
      try {
        final post = await remoteDataSource.getPostList();
        localDataSource.cachePostList(post);
        return Right(post);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      try {
        final localPost = await localDataSource.getLastPostList();
        return Right(localPost);
      } on CacheException {
        return Left(CacheFaliure());
      }
    }
  }
}
