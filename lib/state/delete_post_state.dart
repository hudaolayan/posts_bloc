abstract class DeletePostState {}

class DeletePostStateInitial extends DeletePostState {}

class DeletePostStateLoading extends DeletePostState {}

class DeletePostStateSuccess extends DeletePostState {}

class DeletePostStateError extends DeletePostState {
  final String message;

  DeletePostStateError({required this.message});
}
