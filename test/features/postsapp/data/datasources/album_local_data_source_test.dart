import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/postapp/date/datasources/album_local_data_source.dart';
import 'package:posts/features/postapp/date/models/album_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../features/postsapp/data/models/models.dart' as model;
import '../../../../fixtures/fixture_reader.dart';
import 'album_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AlbumLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        AlbumLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastAlbumList', () {
    List albums = jsonDecode(fixture('album.json'));
    final tAlbumModel = [AlbumModel.fromJson(albums[0])];

    test(
      'Should return Albums from Flutter_Cache when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('album.json'));
        // act
        final result = await dataSource.getLastAlbumList();
        // assert
        verify(mockSharedPreferences.getString(ALBUM_LIST));
        expect(result, equals(tAlbumModel));
      },
    );

    test(
      'Should throw CacheExeption when there is one cache value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getLastAlbumList;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheAlbum', () {
    final tAlbumModel = model.albumModel;
    test(
      'Should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cacheAlbumList(tAlbumModel);
        // assert
        List<Map<String, dynamic>> jsonList = [];
        for (var i = 0; i < tAlbumModel.length; i++) {
          jsonList.add(tAlbumModel[i].toJson());
        }
        verify(
            mockSharedPreferences.setString(ALBUM_LIST, jsonEncode(jsonList)));
      },
    );
  });
}
