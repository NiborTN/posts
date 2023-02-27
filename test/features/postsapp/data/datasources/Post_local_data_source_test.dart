// ignore: file_names
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/postapp/date/datasources/post_local_data_source.dart';
import 'package:posts/features/postapp/date/models/post_model.dart';
import '../../../../features/postsapp/data/models/models.dart' as model;
import '../../../../fixtures/fixture_reader.dart';
import 'album_local_data_source_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late PostLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        PostLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastPostList', () {
    List posts = jsonDecode(fixture('post.json'));
    final tPostModel = [PostModel.fromJson(posts[0])];

    test(
      'Should return Posts from Flutter_Cache when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('Post.json'));
        // act
        final result = await dataSource.getLastPostList();
        // assert
        verify(mockSharedPreferences.getString(POST_LIST));
        expect(result, equals(tPostModel));
      },
    );

    test(
      'Should throw CacheExeption when there is one cache value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getLastPostList;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cachePost', () {
    final tPostModel = model.postModel;
    test(
      'Should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cachePostList(tPostModel);
        // assert
        List<Map<String, dynamic>> jsonList = [];
        for (var i = 0; i < tPostModel.length; i++) {
          jsonList.add(tPostModel[i].toJson());
        }
        verify(
            mockSharedPreferences.setString(POST_LIST, jsonEncode(jsonList)));
      },
    );
  });
}
