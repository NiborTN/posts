import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/core/error/faliures.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/features/postapp/date/datasources/post_local_data_source.dart';
import 'package:posts/features/postapp/date/datasources/post_remote_data_source.dart';
import 'package:posts/features/postapp/date/repository/post_repository_impl.dart';
import 'models.dart' as model;

@GenerateMocks(
  [PostRemoteDataSource, PostLocalDataSource, NetworkInfo],
)
import 'post_repository_impl_test.mocks.dart';

void main() {
  late PostRepositoryImpl repository;
  late MockPostRemoteDataSource mockRemoteDataSource;
  late MockPostLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockPostRemoteDataSource();
    mockLocalDataSource = MockPostLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PostRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getPost', () {
    var tPostModel = [model.postModel];

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'Should return remote data when the call to the remote data source is successful ',
        () async {
          // arrange
          when(mockRemoteDataSource.getPostList())
              .thenAnswer((_) async => tPostModel);
          // act
          final result = await repository.getPostList();
          // assert
          verify(mockRemoteDataSource.getPostList());
          expect(result, right(tPostModel));
        },
      );

      test(
        ' Should return ServerFaliure if RemoteDataSource is unavailable',
        () async {
          // arrange
          when(mockRemoteDataSource.getPostList()).thenThrow(ServerException());
          // act
          final result = await repository.getPostList();
          // assert
          verify(mockRemoteDataSource.getPostList());
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
          when(mockLocalDataSource.getLastPostList())
              .thenAnswer((_) async => tPostModel);
          // act
          final result = await repository.getPostList();
          // assert
          verifyNoMoreInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastPostList());
          expect(result, Right(tPostModel));
        },
      );

      test(
        'Should return cacheFaliure if there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastPostList())
              .thenThrow(CacheException());
          // act
          final result = await repository.getPostList();
          // assert
          verifyNoMoreInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastPostList());
          expect(result, Left(CacheFaliure()));
        },
      );
    });
  });
}
