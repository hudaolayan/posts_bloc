import '../model/post_model.dart';

abstract class GetAllPostsState{}

class GetAllPostsInitial extends GetAllPostsState{}

class GetAllPostStateLoading extends GetAllPostsState{}

class GetAllPostsStateSuccess extends GetAllPostsState {
  final List<PostModel> posts;
  GetAllPostsStateSuccess({required this.posts});
}
class GetAllPostsStateError extends GetAllPostsState {
  final String message;
  GetAllPostsStateError({required this.message});
}

