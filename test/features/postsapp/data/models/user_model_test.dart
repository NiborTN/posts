import 'dart:convert';
import 'package:posts/features/postapp/date/models/user_model.dart';
import 'package:posts/features/postapp/domain/entities/user.dart';
import 'package:test/test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'models.dart' as model;

void main() {
  var tUserModel = model.userModel;

  test(
    'Should be a subcalss of commnets entity',
    () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );

  group('fromJson', () {
    test(
      'Should return a valid model ',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = jsonDecode(fixture('user.json'));
        // act
        final result = UserModel.fromJson(jsonMap);

        // assert
        expect(result, tUserModel);
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
          final result = tUserModel.toJson();
          // assert
          final expectedMap = [
            {'id': 1, 'userName': 'test'}
          ];
          expect(result, expectedMap);
        },
      );
    },
  );
}
