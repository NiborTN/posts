import 'package:dartz/dartz.dart';
import 'package:posts/features/postapp/domain/repositories/comment_repository.dart';
import 'package:posts/features/postapp/domain/usescases/get_comment_list.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/usescases/usecase.dart';
import 'entites_instances.dart' as entity;

@GenerateMocks(
  [CommentRepository],
)
import 'get_comment_test.mocks.dart';

void main() {
  late GetCommentList usecase;
  late MockCommentRepository mockCommentRepository;

  setUp(
    () {
      mockCommentRepository = MockCommentRepository();
      usecase = GetCommentList(mockCommentRepository);
    },
  );

  const postId = 1;

  test(
    'Should get a list of commnets from the repository',
    () async {
      // arrange
      when(mockCommentRepository.getCommentList(any))
          .thenAnswer((_) async => Right(entity.commentsList));
      // act
      final result = await usecase(const Params(id: postId));
      // assert
      expect(result, Right(entity.commentsList));
      verify(mockCommentRepository.getCommentList(postId));
      verifyNoMoreInteractions(mockCommentRepository);
    },
  );
}
