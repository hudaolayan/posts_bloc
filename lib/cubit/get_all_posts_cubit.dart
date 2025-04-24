import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../model/post_model.dart';
import '../state/get_all_posts_state.dart';
import '../util/const_values.dart';

class GetAllPostsCubit extends Cubit<GetAllPostsState> {
  GetAllPostsCubit() : super(GetAllPostsInitial());

  getAllPosts() async {
    emit(GetAllPostStateLoading());
    final response = await http.get(Uri.parse("${ConstValues.baseUrl}posts"));
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      List<PostModel> posts = [];
      for (var element in jsonBody) {
        posts.add(PostModel.fromJson(json: element));
      }
      emit(GetAllPostsStateSuccess(posts: posts));
    } else {
      emit(GetAllPostsStateError(message: "Something went wrong"));
    }
  }

  addPost({required PostModel postModel}) {
    var currentState = state;
    emit(GetAllPostStateLoading());
    if (currentState is GetAllPostsStateSuccess) {
      currentState.posts.insert(0, postModel);
      emit(GetAllPostsStateSuccess(posts: currentState.posts));
    }
  }

  updatePost({required PostModel postModel, required int index}) {
    var currentState = state;
    emit(GetAllPostStateLoading());
    if (currentState is GetAllPostsStateSuccess) {
      currentState.posts[index] = postModel;
      emit(GetAllPostsStateSuccess(posts: currentState.posts));
    }
  }

  updateLoading({required int index}) {
    var currentState = state;
    emit(GetAllPostStateLoading());
    if (currentState is GetAllPostsStateSuccess) {
      currentState.posts[index].isLoading = true;
      emit(GetAllPostsStateSuccess(posts: currentState.posts));
    }
  }

  deletePost({required int index}) {
    var currentState = state;
    emit(GetAllPostStateLoading());
    if (currentState is GetAllPostsStateSuccess) {
      currentState.posts.removeAt(index);
      emit(GetAllPostsStateSuccess(posts: currentState.posts));
    }
  }
}
