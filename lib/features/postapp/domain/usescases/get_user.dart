import 'package:posts/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts/core/usescases/usecase.dart';
import 'package:posts/features/postapp/domain/entities/user.dart';
import 'package:posts/features/postapp/domain/repositories/user_repository.dart';

class GetUser implements UseCase<User, Params> {
  late UserRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Faliure, User>> call(Params params) async {
    return await repository.getUser(params.id);
  }
}
