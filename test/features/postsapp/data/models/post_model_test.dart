import 'dart:convert';
import 'package:posts/features/postapp/date/models/post_model.dart';
import 'package:posts/features/postapp/domain/entities/posts.dart';
import 'package:test/test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'models.dart' as model;

void main() {
  var tPostModel = model.postModel;

  test(
    'Should be a subcalss of commnets entity',
    () async {
      // assert
      expect(tPostModel, isA<Post>());
    },
  );

  group('fromJson', () {
    test(
      'Should return a valid model ',
      () async {
        // arrange
        final List<dynamic> jsonMap = jsonDecode(fixture('post.json'));
        // act
        final result = jsonMap.map((json) {
          return PostModel.fromJson(json);
        }).toList();

        // assert
        expect(result, tPostModel);
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
          final result = tPostModel[0].toJson();
          // assert
          final expectedMap = {
            'userId': 1,
            'id': 1,
            'title': 'test',
            'body': 'test'
          };
          expect(result, expectedMap);
        },
      );
    },
  );
}
