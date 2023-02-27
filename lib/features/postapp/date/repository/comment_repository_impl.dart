import 'package:posts/features/postapp/domain/entities/comment.dart';
import 'package:posts/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts/features/postapp/domain/repositories/comment_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/comment_local_data_source.dart';
import '../datasources/comment_remote_data_source.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;
  final CommentLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CommentRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Faliure, List<Comments>>> getCommentList(int postId) async {
    if (await networkInfo.isConnected) {
      try {
        final comment = await remoteDataSource.getCommentList(postId);
        localDataSource.cacheCommentList(comment);
        return Right(comment);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      try {
        final localComment = await localDataSource.getLastCommentList();
        return Right(localComment);
      } on CacheException {
        return Left(CacheFaliure());
      }
    }
  }
}
