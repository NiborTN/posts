import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final int albumId;
  final int id;
  final String image;

  const Photo({required this.albumId, required this.id, required this.image});

  @override
  List<Object?> get props => [albumId, id, image];
}
