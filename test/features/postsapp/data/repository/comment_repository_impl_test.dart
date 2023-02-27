import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/core/error/faliures.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/features/postapp/date/datasources/comment_local_data_source.dart';
import 'package:posts/features/postapp/date/datasources/comment_remote_data_source.dart';
import 'package:posts/features/postapp/date/repository/comment_repository_impl.dart';
import 'models.dart' as model;
import 'comment_repository_impl_test.mocks.dart';

@GenerateMocks(
  [CommentRemoteDataSource, CommentLocalDataSource, NetworkInfo],
)
void main() {
  late CommentRepositoryImpl repository;
  late MockCommentRemoteDataSource mockRemoteDataSource;
  late MockCommentLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockCommentLocalDataSource();
    mockRemoteDataSource = MockCommentRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CommentRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('getComments', () {
    const tCommentModel = model.commnetsModel;
    int postId = 1;
    group('device online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'Should return remoate data when call to the RemoteDataSource is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getCommentList(postId))
              .thenAnswer((_) async => tCommentModel);
          // act
          final result = await repository.getCommentList(postId);
          // assert
          verify(mockRemoteDataSource.getCommentList(postId));
          expect(result, const Right(tCommentModel));
        },
      );

      test(
        'Should return ServerFaliure if the RemoteDataSource is unavailable',
        () async {
          // arrange
          when(mockRemoteDataSource.getCommentList(postId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getCommentList(postId);
          // assert
          verify(mockRemoteDataSource.getCommentList(postId));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, Left(ServerFaliure()));
        },
      );

      group('device offline', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });

        test(
          'Should return last locally cached data when the cached data is present',
          () async {
            // arrange
            when(mockLocalDataSource.getLastCommentList())
                .thenAnswer((_) async => tCommentModel);
            // act
            final result = await repository.getCommentList(postId);
            // assert
            verifyNoMoreInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastCommentList());
            expect(result, const Right(tCommentModel));
          },
        );

        test(
          'Should return cacheFaliure if there is no cached data present',
          () async {
            // arrange
            when(mockLocalDataSource.getLastCommentList())
                .thenThrow(CacheException());
            // act
            final result = await repository.getCommentList(postId);
            // assert
            verifyNoMoreInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastCommentList());
            expect(result, Left(CacheFaliure()));
          },
        );
      });
    });
  });
}
