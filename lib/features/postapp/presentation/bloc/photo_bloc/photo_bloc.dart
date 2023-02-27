import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/features/postapp/domain/usescases/get_photo_list.dart';
import '../../../../../core/usescases/usecase.dart';
import '../../../presentation/bloc/map_to_faliure.dart' as fail;
import '../../../domain/entities/photo.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotoList getPhotoList;

  PhotoBloc({required this.getPhotoList}) : super(const PhotoLoading()) {
    on<LoadPhoto>((event, emit) async {
      emit(const PhotoLoading());
      final faliureOrphoto = await getPhotoList(Params(id: event.albumId));
      emit(faliureOrphoto.fold(
          (faliure) => Error(message: fail.mapFailureToMessage(faliure)),
          (photo) => PhotoLoaded(photoList: photo, bigImage: photo[0])));
    });

    on<ChangePhoto>((event, emit) async {
      final state = this.state;
      if (state is PhotoLoaded) {
        emit(const PhotoLoading());
        emit(PhotoLoaded(
            photoList: List.from(state.photoList), bigImage: event.photo));
      }
    });
  }
}
