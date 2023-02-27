import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/core/error/faliures.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/features/postapp/date/datasources/photo_local_data_source.dart';
import 'package:posts/features/postapp/date/datasources/photo_remote_data_source.dart';
import 'package:posts/features/postapp/date/repository/photo_repository_impl.dart';
import 'models.dart' as model;

@GenerateMocks(
  [PhotoRemoteDataSource, PhotoLocalDataSource, NetworkInfo],
)
import 'photo_repository_impl_test.mocks.dart';

void main() {
  late PhotoRepositoryImpl repository;
  late MockPhotoRemoteDataSource mockRemoteDataSource;
  late MockPhotoLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockPhotoRemoteDataSource();
    mockLocalDataSource = MockPhotoLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PhotoRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getPhoto', () {
    var tPhotoModel = model.photoModel;
    int albumId = 1;

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'Should return remote data when the call to the remote data source is successful ',
        () async {
          // arrange
          when(mockRemoteDataSource.getPhotoList(albumId))
              .thenAnswer((_) async => tPhotoModel);
          // act
          final result = await repository.getPhotoList(albumId);
          // assert
          verify(mockRemoteDataSource.getPhotoList(albumId));
          expect(result, right(tPhotoModel));
        },
      );

      test(
        ' Should return ServerFaliure if RemoteDataSource is unavailable',
        () async {
          // arrange
          when(mockRemoteDataSource.getPhotoList(albumId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getPhotoList(albumId);
          // assert
          verify(mockRemoteDataSource.getPhotoList(albumId));
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
          when(mockLocalDataSource.getLastPhotoList())
              .thenAnswer((_) async => tPhotoModel);
          // act
          final result = await repository.getPhotoList(albumId);
          // assert
          verifyNoMoreInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastPhotoList());
          expect(result, Right(tPhotoModel));
        },
      );

      test(
        'Should return cacheFaliure if there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastPhotoList())
              .thenThrow(CacheException());
          // act
          final result = await repository.getPhotoList(albumId);
          // assert
          verifyNoMoreInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastPhotoList());
          expect(result, Left(CacheFaliure()));
        },
      );
    });
  });
}
