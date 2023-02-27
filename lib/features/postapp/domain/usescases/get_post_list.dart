import 'package:dartz/dartz.dart';

import '../../../../core/error/faliures.dart';
import '../../../../core/usescases/usecase.dart';
import '../entities/posts.dart';
import '../repositories/post_repository.dart';

class GetPostList implements UseCase<List<Post>, NoParams> {
  late PostRepository repository;

  GetPostList(this.repository);

  @override
  Future<Either<Faliure, List<Post>>> call(NoParams params) async {
    return await repository.getPostList();
  }
}
