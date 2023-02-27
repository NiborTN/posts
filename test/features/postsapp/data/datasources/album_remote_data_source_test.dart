import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/postapp/date/datasources/album_remote_data_source.dart';
import 'package:posts/features/postapp/date/models/album_model.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateMocks([http.Client])
import 'album_remote_data_source_test.mocks.dart';

void main() {
  late AlbumRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = AlbumRemoteDataSourceImpl(client: mockClient);
  });

  void mockHttp200() {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('album.json'), 200));
  }

  group('getAlbumList', () {
    final tAlbumModel = jsonDecode(fixture('album.json')).map((json) {
      return AlbumModel.fromJson(json);
    }).toList();

    test(
      'Should perform a GET request on the URL with Album being the endpoint',
      () async {
        // arrange
        mockHttp200();
        // act
        dataSource.getAlbumList();
        // assert
        var url = Uri.https('jsonplaceholder.typicode.com', 'albums');
        verify(mockClient.get(url));
      },
    );

    test(
      'Should should return AlbumModel when the respoces code is 200 (successful)',
      () async {
        // arrange
        mockHttp200();
        // act
        final result = await dataSource.getAlbumList();
        // assert
        expect(result, equals(tAlbumModel));
      },
    );

    test(
      'Should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('something went wrong', 404));
        // act
        final call = dataSource.getAlbumList;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
