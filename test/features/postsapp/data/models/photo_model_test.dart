import 'dart:convert';
import 'package:posts/features/postapp/date/models/photo_model.dart';
import 'package:posts/features/postapp/domain/entities/photo.dart';
import 'package:test/test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'models.dart' as model;

void main() {
  const tPhotoModel = model.photoModel;

  test(
    'Should be a subclass of Photo entity ',
    () async {
      // assert
      expect(tPhotoModel, isA<List<Photo>>());
    },
  );
  group('fromJson', () {
    test(
      'Should return a valid model ',
      () async {
        // arrange
        final List<dynamic> jsonList = jsonDecode(fixture('photo.json'));
        // act
        final result = jsonList.map((json) {
          return PhotoModel.fromJson(json);
        }).toList();
        // assert
        expect(result, tPhotoModel);
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
          final result = tPhotoModel[0].toJson();
          // assert
          final expectedMap = [
            {'albumId': 1, 'id': 1, 'image': 'test'}
          ];
          expect(result, expectedMap);
        },
      );
    },
  );
}
