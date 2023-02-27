import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Faliure extends Equatable {
  const Faliure([List properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [];
}

//General Faliures
// ignore: must_be_immutable
class ServerFaliure extends Faliure {
  ServerFaliure();
}

// ignore: must_be_immutable
class CacheFaliure extends Faliure {
  CacheFaliure();
}
