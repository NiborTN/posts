import 'package:posts/features/postapp/domain/entities/user.dart';
import 'package:posts/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts/features/postapp/domain/repositories/user_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Faliure, User>> getUser(userId) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.getUser(userId);
        localDataSource.cacheUserList(user);
        return Right(user);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      try {
        final localUser = await localDataSource.getLastUserList();
        return Right(localUser);
      } on CacheException {
        return Left(CacheFaliure());
      }
    }
  }
}
