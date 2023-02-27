import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/postapp/date/datasources/photo_remote_data_source.dart';
import 'package:posts/features/postapp/date/models/photo_model.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'album_remote_data_source_test.mocks.dart';

void main() {
  late PhotoRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = PhotoRemoteDataSourceImpl(client: mockClient);
  });

  void mockHttp200() {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('photo.json'), 200));
  }

  group('getPhotoPhotoList', () {
    final tPhotoModel = jsonDecode(fixture('photo.json')).map((json) {
      return PhotoModel.fromJson(json);
    }).toList();

    const tAlbumId = 1;
    test(
      'Should perform a GET request on the URL with Photo being the endpoint',
      () async {
        // arrange
        mockHttp200();
        // act
        dataSource.getPhotoList(tAlbumId);
        // assert
        var url = Uri.https('jsonplaceholder.typicode.com', 'photos',
            {'albumId': tAlbumId.toString()});
        verify(mockClient.get(url));
      },
    );

    test(
      'Should should return PostModel when the respoces code is 200 (successful)',
      () async {
        // arrange
        mockHttp200();
        // act
        final result = await dataSource.getPhotoList(tAlbumId);
        // assert
        expect(result, equals(tPhotoModel));
      },
    );

    test(
      'Should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('something went wrong', 404));
        // act
        final call = dataSource.getPhotoList;
        // assert
        expect(() => call(tAlbumId),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
