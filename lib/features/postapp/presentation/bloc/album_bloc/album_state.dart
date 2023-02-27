part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumLoading extends AlbumState {
  const AlbumLoading();
}

class AlbumLoaded extends AlbumState {
  final List<Album> albumList;

  const AlbumLoaded({required this.albumList});
}

class Error extends AlbumState {
  final String message;

  const Error({required this.message});
}
