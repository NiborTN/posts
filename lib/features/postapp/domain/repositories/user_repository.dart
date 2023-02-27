import 'package:dartz/dartz.dart';
import 'package:posts/features/postapp/domain/entities/user.dart';

import '../../../../core/error/faliures.dart';
import '../entities/album.dart';

abstract class UserRepository {
  Future<Either<Faliure, User>> getUser(userId);
}
