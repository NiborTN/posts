import 'dart:convert';
import 'package:posts/features/postapp/date/models/comments_model.dart';
import 'package:posts/features/postapp/domain/entities/comment.dart';
import 'package:test/test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'models.dart' as model;

void main() {
  const tCommentModel = model.commnetsModel;

  test(
    'Should be a subcalss of commnets entity',
    () async {
      // assert
      expect(tCommentModel, isA<List<Comments>>());
    },
  );

  group('fromJson', () {
    test(
      'Should return a valid model ',
      () async {
        // arrange
        final List<dynamic> jsonList = jsonDecode(fixture('Comments.json'));
        // act
        final result = jsonList.map((json) {
          return CommentsModel.fromJson(json);
        }).toList();
        // assert
        expect(result, tCommentModel);
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
          final result = tCommentModel[0].toJson();
          // assert
          final expectedMap = [
            {'postId': 1, 'id': 1, 'body': 'test'}
          ];
          expect(result, expectedMap);
        },
      );
    },
  );
}
