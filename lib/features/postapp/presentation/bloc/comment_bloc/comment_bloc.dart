import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/features/postapp/domain/usescases/get_comment_list.dart';
import '../../../../../core/usescases/usecase.dart';
import '../../../presentation/bloc/map_to_faliure.dart' as fail;
import '../../../domain/entities/comment.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentList getCommentList;

  CommentBloc({required this.getCommentList}) : super(const CommentLoading()) {
    on<LoadComment>((event, emit) async {
      emit(const CommentLoading());
      final faliureOrcomment = await getCommentList(Params(id: event.postId));
      emit(faliureOrcomment.fold(
          (faliure) => Error(message: fail.mapFailureToMessage(faliure)),
          (comment) => CommentLoaded(commentList: comment)));
    });
  }
}
