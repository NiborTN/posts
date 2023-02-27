import 'package:dartz/dartz.dart';
import 'package:posts/features/postapp/domain/repositories/user_repository.dart';
import 'package:posts/features/postapp/domain/usescases/get_user.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/usescases/usecase.dart';
import 'entites_instances.dart' as entity;

@GenerateMocks(
  [UserRepository],
)
import 'get_user_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetUser(mockUserRepository);
  });

  const userId = 1;
  test(
    'Should return a user from the repository',
    () async {
      // arrange
      when(mockUserRepository.getUser(any))
          .thenAnswer((_) async => Right(entity.user));
      // act
      final result = await usecase(const Params(id: userId));
      // assert
      expect(result, Right(entity.user));
      verify(mockUserRepository.getUser(userId));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
