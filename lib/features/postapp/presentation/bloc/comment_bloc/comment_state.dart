part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {
  const CommentLoading();
}

class CommentLoaded extends CommentState {
  final List<Comments> commentList;

  const CommentLoaded({required this.commentList});
}

class Error extends CommentState {
  final String message;

  const Error({required this.message});
}
