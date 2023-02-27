import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/usescases/usecase.dart';
import 'package:posts/features/postapp/domain/repositories/photo_repository.dart';
import 'package:posts/features/postapp/domain/usescases/get_photo_list.dart';
import 'entites_instances.dart' as entity;

@GenerateMocks(
  [PhotoRepository],
)
import 'get_photo_test.mocks.dart';

void main() {
  late GetPhotoList usecase;
  late MockPhotoRepository mockPhotoRepository;

  setUp(
    () {
      mockPhotoRepository = MockPhotoRepository();
      usecase = GetPhotoList(mockPhotoRepository);
    },
  );

  const albumId = 1;
  test(
    'Should should get a list of Photos from the repository',
    () async {
      // arrange
      when(mockPhotoRepository.getPhotoList(any))
          .thenAnswer((_) async => Right(entity.photoList));
      // act
      final result = await usecase(const Params(id: albumId));
      // assert
      expect(result, Right(entity.photoList));
      verify(mockPhotoRepository.getPhotoList(albumId));
      verifyNoMoreInteractions(mockPhotoRepository);
    },
  );
}
