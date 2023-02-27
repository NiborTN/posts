part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  const PostLoading();
}

class PostLoaded extends PostState {
  final List<Post> postList;

  const PostLoaded({required this.postList});
}

class Error extends PostState {
  final String message;

  const Error({required this.message});
}
