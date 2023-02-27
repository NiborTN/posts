import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/core/usescases/usecase.dart';
import 'package:posts/features/postapp/domain/entities/album.dart';
import 'package:posts/features/postapp/domain/usescases/get_album_list.dart';
import '../../../presentation/bloc/map_to_faliure.dart' as fail;

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbumList getAlbumList;

  AlbumBloc({required this.getAlbumList}) : super(const AlbumLoading()) {
    on<LoadAlbum>((event, emit) async {
      emit(const AlbumLoading());
      final faliureOrAlbum = await getAlbumList(NoParams());
      emit(faliureOrAlbum.fold(
          (faliure) => Error(message: fail.mapFailureToMessage(faliure)),
          (album) => AlbumLoaded(albumList: album)));
    });
  }
}
