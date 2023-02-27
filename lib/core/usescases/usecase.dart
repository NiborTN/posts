import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/faliures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Faliure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
