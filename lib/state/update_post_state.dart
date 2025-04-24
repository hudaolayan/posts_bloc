import 'package:posts_bloc/model/post_model.dart';

abstract class UpdatePostState {}

class UpdatePostStateInitial extends UpdatePostState {}

class UpdatePostStateLoading extends UpdatePostState {}

class UpdatePostStateSuccess extends UpdatePostState {
  final PostModel postModel;

  UpdatePostStateSuccess({required this.postModel});
}

class UpdatePostStateError extends UpdatePostState {
  final String message;

  UpdatePostStateError({required this.message});
}
