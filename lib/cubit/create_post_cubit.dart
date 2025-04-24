import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:posts_bloc/model/post_model.dart';
import 'package:posts_bloc/state/create_post_state.dart';
import 'package:posts_bloc/util/const_values.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostStateInitial());

  createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    emit(CreatePostStateLoading());

    String errorTitle = "";
    String errorBody = "";

    if (title.isEmpty) {
      errorTitle = "Please enter title";
    }
    if (body.isEmpty) {
      errorBody = "Please enter body";
    }
    if (errorTitle.isNotEmpty || errorBody.isNotEmpty) {
      emit(CreatePostStateError(message: "$errorTitle\n$errorBody"));
      return;
    }

    final response = await http.post(
      Uri.parse("${ConstValues.baseUrl}posts"),
      body: jsonEncode({"title": title, "body": body, "userId": userId}),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 201) {
      emit(
        CreatePostStateSuccess(
          postModel: PostModel.fromJson(json: jsonDecode(response.body)),
        ),
      );
    } else {
      emit(CreatePostStateError(message: "Something wont wrong"));
    }
  }
}
