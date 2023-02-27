import 'dart:convert';
import 'package:posts/features/postapp/date/models/album_model.dart';
import 'package:posts/features/postapp/domain/entities/album.dart';
import 'package:test/test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'models.dart' as model;

void main() {
  var tAlbumModel = model.albumModel;

  test(
    'Should be a subcalss of commnets entity',
    () async {
      // assert
      expect(tAlbumModel, isA<Album>());
    },
  );

  group('fromJson', () {
    test(
      'Should return a valid model ',
      () async {
        // arrange
        final List<dynamic> jsonMap = jsonDecode(fixture('album.json'));
        // act
        final result = jsonMap.map((json) {
          return AlbumModel.fromJson(json);
        }).toList();

        // assert
        expect(result, tAlbumModel);
      },
    );
  });

  group(
    'toJson',
    () {
      test(
        'Should return a json map cantaining the propper values',
        () async {
          // act
          final result = tAlbumModel[0].toJson();
          // assert
          final expectedMap = {'userId': 1, 'id': 1, 'title': 'test'};
          expect(result, expectedMap);
        },
      );
    },
  );
}
