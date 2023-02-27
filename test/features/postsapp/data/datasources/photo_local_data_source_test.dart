import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/postapp/date/datasources/photo_local_data_source.dart';
import 'package:posts/features/postapp/date/models/photo_model.dart';
import '../../../../features/postsapp/data/models/models.dart' as model;
import '../../../../fixtures/fixture_reader.dart';
import 'album_local_data_source_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late PhotoLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        PhotoLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastPhotoList', () {
    List photos = jsonDecode(fixture('Photo_cached.json'));
    final tPhotoModel = [PhotoModel.fromJson(photos[0])];

    test(
      'Should return Photos from Flutter_Cache when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('Photo_cached.json'));
        // act
        final result = await dataSource.getLastPhotoList();
        // assert
        verify(mockSharedPreferences.getString(PHOTO_LIST));
        expect(result, equals(tPhotoModel));
      },
    );

    test(
      'Should throw CacheExeption when there is one cache value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getLastPhotoList;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cachePhoto', () {
    final tPhotoModel = model.photoModel;
    test(
      'Should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cachePhotoList(tPhotoModel);
        // assert
        List<Map<String, dynamic>> jsonList = [];
        for (var i = 0; i < tPhotoModel.length; i++) {
          jsonList.add(tPhotoModel[i].toJson());
        }
        verify(
            mockSharedPreferences.setString(PHOTO_LIST, jsonEncode(jsonList)));
      },
    );
  });
}
