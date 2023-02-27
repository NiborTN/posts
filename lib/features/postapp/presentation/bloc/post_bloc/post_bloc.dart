import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../presentation/bloc/map_to_faliure.dart' as fail;
import '../../../../../core/usescases/usecase.dart';
import '../../../domain/entities/posts.dart';
import '../../../domain/usescases/get_post_list.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostList getPostList;

  PostBloc({required this.getPostList}) : super(const PostLoading()) {
    on<LoadPost>((event, emit) async {
      emit(const PostLoading());
      final faliureOrPost = await getPostList(NoParams());
      emit(faliureOrPost.fold(
          (faliure) => Error(message: fail.mapFailureToMessage(faliure)),
          (post) => PostLoaded(postList: post)));
    });
  }
}
