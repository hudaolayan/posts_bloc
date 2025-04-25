import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_bloc/cubit/get_post_comments_cubit.dart';
import 'package:posts_bloc/state/get_post_comments_state.dart';
import 'package:posts_bloc/view/widget/comment_widget.dart';

import '../../model/post_model.dart';

class PostScreen extends StatelessWidget {
  PostModel postModel;

  PostScreen({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postModel.title.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 8),
            Text(postModel.body.toString(), style: TextStyle(fontSize: 14.0)),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context.read<GetPostCommentsCubit>().fetchCommentsForPost(
                  postModel.id!,
                );
              },
              icon: Icon(Icons.comment),
              label: Text("Load Comments"),
            ),
            SizedBox(height: 8),
            Text(
              "Tap the button to load comments",
              style: TextStyle(fontSize: 13.0, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<GetPostCommentsCubit, GetPostCommentsState>(
                builder: (context, state) {
                  if (state is GetPostCommentsStateLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetPostCommentsStateError) {
                    return Center(child: Text(state.message));
                  } else if (state is GetPostCommentsStateSuccess) {
                    if (state.comments.isEmpty ||
                        state.comments.first.postId != postModel.id) {
                      return Center(child: Text("No comments found."));
                    }

                    return ListView.builder(
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        return CommentWidget(
                          commentModel: state.comments[index],
                        );
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
