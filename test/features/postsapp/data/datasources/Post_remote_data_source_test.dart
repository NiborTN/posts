// ignore: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/postapp/date/datasources/post_remote_data_source.dart';
import 'package:posts/features/postapp/date/models/post_model.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'album_remote_data_source_test.mocks.dart';

void main() {
  late PostRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = PostRemoteDataSourceImpl(client: mockClient);
  });

  void mockHttp200() {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('post.json'), 200));
  }

  group('getPostList', () {
    final tPostModel = jsonDecode(fixture('post.json')).map((json) {
      return PostModel.fromJson(json);
    }).toList();

    test(
      'Should perform a GET request on the URL with Post being the endpoint',
      () async {
        // arrange
        mockHttp200();
        // act
        dataSource.getPostList();
        // assert
        var url = Uri.https('jsonplaceholder.typicode.com', 'posts');
        verify(mockClient.get(url));
      },
    );

    test(
      'Should should return PostModel when the respoces code is 200 (successful)',
      () async {
        // arrange
        mockHttp200();
        // act
        final result = await dataSource.getPostList();
        // assert
        expect(result, equals(tPostModel));
      },
    );

    test(
      'Should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('something went wrong', 404));
        // act
        final call = dataSource.getPostList;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
