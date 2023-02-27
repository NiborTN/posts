import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/core/error/faliures.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/features/postapp/date/datasources/user_local_data_source.dart';
import 'package:posts/features/postapp/date/datasources/user_remote_data_source.dart';
import 'package:posts/features/postapp/date/repository/user_repository_impl_test.dart';
import 'models.dart' as model;

@GenerateMocks(
  [UserRemoteDataSource, UserLocalDataSource, NetworkInfo],
)
import 'user_repository_impl_test.mocks.dart';

void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemoteDataSource;
  late MockUserLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getUser', () {
    var tUserModel = model.userModel;
    int userId = 1;
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'Should return remote data when the call to the remote data source is successful ',
        () async {
          // arrange
          when(mockRemoteDataSource.getUser(any))
              .thenAnswer((_) async => tUserModel);
          // act
          final result = await repository.getUser(userId);
          // assert
          verify(mockRemoteDataSource.getUser(userId));
          expect(result, right(tUserModel));
        },
      );

      test(
        ' Should return ServerFaliure if RemoteDataSource is unavailable',
        () async {
          // arrange
          when(mockRemoteDataSource.getUser(any)).thenThrow(ServerException());
          // act
          final result = await repository.getUser(userId);
          // assert
          verify(mockRemoteDataSource.getUser(userId));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, Left(ServerFaliure()));
        },
      );
    });
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'Should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastUserList())
              .thenAnswer((_) async => tUserModel);
          // act
          final result = await repository.getUser(userId);
          // assert
          verifyNoMoreInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastUserList());
          expect(result, Right(tUserModel));
        },
      );

      test(
        'Should return cacheFaliure if there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastUserList())
              .thenThrow(CacheException());
          // act
          final result = await repository.getUser(userId);
          // assert
          verifyNoMoreInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastUserList());
          expect(result, Left(CacheFaliure()));
        },
      );
    });
  });
}
