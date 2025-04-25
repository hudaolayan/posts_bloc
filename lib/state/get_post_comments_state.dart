import '../model/comment_model.dart';

abstract class GetPostCommentsState {}

class GetPostCommentsStateInitial extends GetPostCommentsState {}

class GetPostCommentsStateLoading extends GetPostCommentsState {}

class GetPostCommentsStateSuccess extends GetPostCommentsState {
  final List<CommentModel> comments;

  GetPostCommentsStateSuccess({required this.comments});
}

class GetPostCommentsStateError extends GetPostCommentsState {
  final String message;

  GetPostCommentsStateError({required this.message});
}
