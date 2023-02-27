// ignore: file_names
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/postapp/date/datasources/comment_local_data_source.dart';
import 'package:posts/features/postapp/date/models/comments_model.dart';
import '../../../../features/postsapp/data/models/models.dart' as model;
import '../../../../fixtures/fixture_reader.dart';
import 'album_local_data_source_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late CommentLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        CommentLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastAlbumList', () {
    List comments = jsonDecode(fixture('comments_cached.json'));
    final tCommentsModel = [CommentsModel.fromJson(comments[0])];

    test(
      'Should return Comments from Flutter_Cache when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('comments_cached.json'));
        // act
        final result = await dataSource.getLastCommentList();
        // assert
        verify(mockSharedPreferences.getString(COMMENT_LIST));
        expect(result, equals(tCommentsModel));
      },
    );

    test(
      'Should throw CacheExeption when there is one cache value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getLastCommentList;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheComments', () {
    const tCommentsModel = model.commnetsModel;
    test(
      'Should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cacheCommentList(tCommentsModel);
        // assert
        List<Map<String, dynamic>> jsonList = [];
        for (var i = 0; i < tCommentsModel.length; i++) {
          jsonList.add(tCommentsModel[i].toJson());
        }
        verify(mockSharedPreferences.setString(
            COMMENT_LIST, jsonEncode(jsonList)));
      },
    );
  });
}
