import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/usescases/usecase.dart';
import 'package:posts/features/postapp/domain/repositories/album_repository.dart';
import 'package:posts/features/postapp/domain/usescases/get_album_list.dart';
import 'entites_instances.dart' as entity;

@GenerateMocks(
  [AlbumRepository],
)
import 'get_album_test.mocks.dart';

void main() {
  late GetAlbumList usecase;
  late MockAlbumRepository mockAlbumRepository;

  setUp(() {
    mockAlbumRepository = MockAlbumRepository();
    usecase = GetAlbumList(mockAlbumRepository);
  });

  test(
    'Should get a list of albums from the repository',
    () async {
      // arrange
      when(mockAlbumRepository.getAlbumList())
          .thenAnswer((_) async => Right(entity.albumList));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(entity.albumList));
      verify(mockAlbumRepository.getAlbumList());
      verifyNoMoreInteractions(mockAlbumRepository);
    },
  );
}
