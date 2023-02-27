import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/core/error/faliures.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/features/postapp/date/repository/album_repository_impl.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:posts/features/postapp/date/datasources/album_local_data_source.dart';
import 'package:posts/features/postapp/date/datasources/album_remote_data_source.dart';
import 'models.dart' as model;
@GenerateMocks(
  [AlbumRemoteDataSource, AlbumLocalDataSource, NetworkInfo],
)
import 'album_repository_impl_test.mocks.dart';

void main() {
  late AlbumRepositoryImpl repository;
  late MockAlbumRemoteDataSource mockRemoteDataSource;
  late MockAlbumLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockAlbumRemoteDataSource();
    mockLocalDataSource = MockAlbumLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AlbumRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getAlbum', () {
    var tAlbumModel = [model.albumModel];

    // test(
    //   'Should check if the device is online',
    //   () async {
    //     // arrange
    //     when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //     // act
    //     await repository.getAlbumList();
    //     // assert
    //     verify(mockNetworkInfo.isConnected);
    //   },
    // );

    group('device is online ', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'Should return remote data when the call to the remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAlbumList())
              .thenAnswer((_) async => tAlbumModel);
          // act
          final result = await repository.getAlbumList();
          // assert
          verify(mockRemoteDataSource.getAlbumList());
          expect(result, Right(tAlbumModel));
        },
      );

      test(
        'Should return ServerFaliure if RemoteDataSource is unavailable',
        () async {
          // arrange
          when(mockRemoteDataSource.getAlbumList())
              .thenThrow(ServerException());
          // act
          final result = await repository.getAlbumList();
          // assert
          verify(mockRemoteDataSource.getAlbumList());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, left(ServerFaliure()));
        },
      );
    });

    group(
      'device is offline ',
      () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });

        test(
          'Should return last locally cached data when the cached data is present',
          () async {
            // arrange
            when(mockLocalDataSource.getLastAlbumList())
                .thenAnswer((_) async => tAlbumModel);
            // act
            final result = await repository.getAlbumList();
            // assert
            verifyNoMoreInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastAlbumList());
            expect(result, Right(tAlbumModel));
          },
        );

        test(
          'Should return cacheFaliure if there is no cached data present',
          () async {
            // arrange
            when(mockLocalDataSource.getLastAlbumList())
                .thenThrow(CacheException());
            // act
            final result = await repository.getAlbumList();
            // assert
            verifyNoMoreInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastAlbumList());
            expect(result, Left(CacheFaliure()));
          },
        );
      },
    );
  });
}
