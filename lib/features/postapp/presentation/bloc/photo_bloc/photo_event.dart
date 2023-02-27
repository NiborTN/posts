part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}

class LoadPhoto extends PhotoEvent {
  final int albumId;

  const LoadPhoto({required this.albumId});
}

class ChangePhoto extends PhotoEvent {
  final Photo photo;

  const ChangePhoto(this.photo);
}
