import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/postapp/date/datasources/comment_remote_data_source.dart';
import 'package:posts/features/postapp/date/models/comments_model.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'album_remote_data_source_test.mocks.dart';

void main() {
  late CommentRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = CommentRemoteDataSourceImpl(client: mockClient);
  });

  void mockHttp200() {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('comments.json'), 200));
  }

  group('getCommentPhotoList', () {
    final tCommentsModel = jsonDecode(fixture('comments.json')).map((json) {
      return CommentsModel.fromJson(json);
    }).toList();

    const tPostId = 1;
    test(
      'Should perform a GET request on the URL with Comments being the endpoint',
      () async {
        // arrange
        mockHttp200();
        // act
        dataSource.getCommentList(tPostId);
        // assert
        var url = Uri.https('jsonplaceholder.typicode.com', 'comments',
            {'postId': tPostId.toString()});
        verify(mockClient.get(url));
      },
    );

    test(
      'Should should return PostModel when the respoces code is 200 (successful)',
      () async {
        // arrange
        mockHttp200();
        // act
        final result = await dataSource.getCommentList(tPostId);
        // assert
        expect(result, equals(tCommentsModel));
      },
    );

    test(
      'Should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('something went wrong', 404));
        // act
        final call = dataSource.getCommentList;
        // assert
        expect(
            () => call(tPostId), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
