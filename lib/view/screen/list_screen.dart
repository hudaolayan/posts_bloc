import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_bloc/view/screen/create_post_screen.dart';

import '../../cubit/get_all_posts_cubit.dart';
import '../../state/get_all_posts_state.dart';
import '../widget/post_widget.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts"),),
      body: BlocBuilder<GetAllPostsCubit, GetAllPostsState>(
        builder: (context, state) {
          if (state is GetAllPostsStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetAllPostsStateSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<GetAllPostsCubit>().getAllPosts();
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return PostWidget(
                    postModel: state.posts[index],
                    index: index,
                  );
                },
                itemCount: state.posts.length,
              ),
            );
          } else if (state is GetAllPostsStateError) {
            return Center(child: Text(state.message));
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
