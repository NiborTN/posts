import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/postapp/date/datasources/user_local_data_source.dart';
import 'package:posts/features/postapp/date/models/user_model.dart';
import '../../../../features/postsapp/data/models/models.dart' as model;
import '../../../../fixtures/fixture_reader.dart';
import 'album_local_data_source_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late UserLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        UserLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastUserList', () {
    Map<String, dynamic> user = jsonDecode(fixture('user_cached.json'));
    final tUserModel = UserModel.fromJson(user);

    test(
      'Should return User from Flutter_Cache when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('user_cached.json'));
        // act
        final result = await dataSource.getLastUserList();
        // assert
        verify(mockSharedPreferences.getString(CACHED_USER));
        expect(result, equals(tUserModel));
      },
    );

    test(
      'Should throw CacheExeption when there is one cache value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getLastUserList;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheUser', () {
    const tUserModel = model.userModel;
    test(
      'Should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cacheUserList(tUserModel);
        // assert
        final expectedJsonString = jsonEncode(tUserModel.toJson());
        verify(
            mockSharedPreferences.setString(CACHED_USER, expectedJsonString));
      },
    );
  });
}
