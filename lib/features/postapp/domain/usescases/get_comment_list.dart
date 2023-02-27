import '../../../../core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usescases/usecase.dart';
import '../entities/comment.dart';
import '../repositories/comment_repository.dart';

class GetCommentList implements UseCase<List<Comments>, Params> {
  final CommentRepository repository;

  GetCommentList(this.repository);

  @override
  Future<Either<Faliure, List<Comments>>> call(Params params) async {
    return await repository.getCommentList(params.id);
  }
}
