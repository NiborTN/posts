import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/postapp/date/datasources/user_remote_data_source.dart';
import 'package:posts/features/postapp/date/models/user_model.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'album_remote_data_source_test.mocks.dart';

void main() {
  late UserRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = UserRemoteDataSourceImpl(client: mockClient);
  });

  void mockHttp200() {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('user.json'), 200));
  }

  group('getUserList', () {
    final tUserModel = UserModel.fromJson(jsonDecode(fixture('user.json')));

    const tUserId = 1;

    test(
      'Should perform a GET request on the URL with User being the endpoint',
      () async {
        // arrange
        mockHttp200();
        // act
        dataSource.getUser(tUserId);
        // assert
        var url = Uri.https('jsonplaceholder.typicode.com', 'users/$tUserId');
        verify(mockClient.get(url));
      },
    );

    test(
      'Should should return PostModel when the respoces code is 200 (successful)',
      () async {
        // arrange
        mockHttp200();
        // act
        final result = await dataSource.getUser(tUserId);
        // assert
        expect(result, equals(tUserModel));
      },
    );

    test(
      'Should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('something went wrong', 404));
        // act
        final call = dataSource.getUser;
        // assert
        expect(
            () => call(tUserId), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
