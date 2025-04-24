import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:posts_bloc/model/post_model.dart';
import 'package:posts_bloc/util/const_values.dart';

import '../state/update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  UpdatePostCubit() : super(UpdatePostStateInitial());

  updatePost({
    required String title,
    required String body,
    required int userId,
    required int id,
  }) async {
    emit(UpdatePostStateLoading());

    String errorTitle = "";
    String errorBody = "";

    if (title.isEmpty) {
      errorTitle = "Please enter title";
    }
    if (body.isEmpty) {
      errorBody = "Please enter body";
    }
    if (errorTitle.isNotEmpty || errorBody.isNotEmpty) {
      emit(UpdatePostStateError(message: "$errorTitle\n$errorBody"));
      return;
    }

    final response = await http.put(
      Uri.parse("${ConstValues.baseUrl}posts/$id"),
      body: jsonEncode({
        "title": title,
        "body": body,
        "userId": userId,
        "id": id,
      }),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      print("resulttttt "+response.body.toString());
      emit(
        UpdatePostStateSuccess(
          postModel: PostModel.fromJson(json: jsonDecode(response.body)),
        ),
      );
    } else {
      print("error resultttt"+response.toString());
      emit(UpdatePostStateError(message: "Something wont wrong"));
    }
  }
}
