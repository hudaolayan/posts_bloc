import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:posts_bloc/state/delete_post_state.dart';
import 'package:posts_bloc/util/const_values.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit() : super(DeletePostStateInitial());

  deletePost({required int id}) async {
    emit(DeletePostStateLoading());

    final response = await http.delete(
      Uri.parse("${ConstValues.baseUrl}posts/$id"),
    );

    if (response.statusCode == 200) {
      emit(DeletePostStateSuccess());
    } else {
      emit(DeletePostStateError(message: "Something went wrong"));
    }
  }
}
