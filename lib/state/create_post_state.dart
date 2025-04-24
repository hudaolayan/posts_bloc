import 'package:posts_bloc/model/post_model.dart';

abstract class CreatePostState {}

class CreatePostStateInitial extends CreatePostState {}

class CreatePostStateLoading extends CreatePostState {}

class CreatePostStateSuccess extends CreatePostState {
  final PostModel postModel;

  CreatePostStateSuccess({required this.postModel});
}

class CreatePostStateError extends CreatePostState {
  final String message;

  CreatePostStateError({required this.message});
}
