import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:posts_bloc/model/comment_model.dart';
import 'package:posts_bloc/state/get_post_comments_state.dart';

import '../util/const_values.dart';

class GetPostCommentsCubit extends Cubit<GetPostCommentsState> {
  GetPostCommentsCubit() : super(GetPostCommentsStateInitial());

  fetchCommentsForPost(int postId) async {
    print("loading comments.....");
    emit(GetPostCommentsStateLoading());
    final response = await http.get(
      Uri.parse("${ConstValues.baseUrl}posts/$postId/comments"),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      List<CommentModel> comments = [];
      for (var element in jsonBody) {
        comments.add(CommentModel.fromJson(json: element));
      }
      emit(GetPostCommentsStateSuccess(comments: comments));
      print(comments.toString());
    } else {
      emit(GetPostCommentsStateError(message: "Something went wrong"));
      print("not ok errorrrrrr");
    }
  }
}
