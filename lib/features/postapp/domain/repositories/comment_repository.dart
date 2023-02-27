import 'package:dartz/dartz.dart';
import 'package:posts/features/postapp/domain/entities/comment.dart';

import '../../../../core/error/faliures.dart';

abstract class CommentRepository {
  Future<Either<Faliure, List<Comments>>> getCommentList(int postId);
}
