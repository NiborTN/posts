import 'package:dartz/dartz.dart';
import 'package:posts/core/usescases/usecase.dart';
import 'package:posts/features/postapp/domain/repositories/post_repository.dart';
import 'package:posts/features/postapp/domain/usescases/get_post_list.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'entites_instances.dart' as entity;

@GenerateMocks(
  [PostRepository],
)
import 'get_post_test.mocks.dart';

void main() {
  late GetPostList usecase;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    usecase = GetPostList(mockPostRepository);
  });

  test(
    'Should should get a list of post form the repository',
    () async {
      // arrange
      when(mockPostRepository.getPostList())
          .thenAnswer((_) async => Right(entity.postList));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(entity.postList));
      verify(mockPostRepository.getPostList());
      verifyNoMoreInteractions(mockPostRepository);
    },
  );
}
