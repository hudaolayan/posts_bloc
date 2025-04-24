import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_bloc/cubit/delete_post_cubit.dart';
import 'package:posts_bloc/cubit/get_all_posts_cubit.dart';
import 'package:posts_bloc/state/delete_post_state.dart';
import 'package:posts_bloc/view/screen/update_post_screen.dart';

import '../../model/post_model.dart';

class PostWidget extends StatelessWidget {
  final PostModel postModel;
  final int index;

  const PostWidget({super.key, required this.postModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(postModel.title ?? "-"),
        Text(postModel.body ?? "-"),
        Row(
          children: [
            postModel.isLoading!
                ? CircularProgressIndicator()
                : BlocListener<DeletePostCubit, DeletePostState>(
                  listener: (context, state){},
                  child: IconButton(
                    onPressed: () async {
                      context.read<GetAllPostsCubit>().updateLoading(
                        index: index,
                      );
                      await context.read<DeletePostCubit>().deletePost(
                        id: postModel.id!,
                      );

                      context.read<GetAllPostsCubit>().deletePost(index: index);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => UpdatePostScreen(
                          postModel: postModel,
                          index: index,
                        ),
                  ),
                );
              },
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ],
    );
  }
}
