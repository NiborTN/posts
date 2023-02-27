import '../../../../core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usescases/usecase.dart';
import '../repositories/photo_repository.dart';

import '../entities/photo.dart';

class GetPhotoList implements UseCase<List<Photo>, Params> {
  final PhotoRepository repository;

  GetPhotoList(this.repository);

  @override
  Future<Either<Faliure, List<Photo>>> call(Params params) async {
    return await repository.getPhotoList(params.id);
  }
}
