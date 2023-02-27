part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class PhotoLoading extends PhotoState {
  const PhotoLoading();
}

class PhotoLoaded extends PhotoState {
  final List<Photo> photoList;
  final Photo bigImage;

  const PhotoLoaded({required this.bigImage, required this.photoList});
}

class Error extends PhotoState {
  final String message;

  const Error({required this.message});
}
