import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_bloc/cubit/create_post_cubit.dart';
import 'package:posts_bloc/cubit/get_all_posts_cubit.dart';
import 'package:posts_bloc/state/create_post_state.dart';
import 'package:posts_bloc/view/widget/custom_button.dart';
import 'package:posts_bloc/view/widget/custom_text_field.dart';

class CreatePostScreen extends StatelessWidget {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController bodyTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              CustomTextField(
                textEditingController: titleTextEditingController,
                label: "Title",
                hintText: "please enter title",
                prefixIcon: Icon(Icons.title),
              ),
              SizedBox(height: 20),
              CustomTextField(
                textEditingController: bodyTextEditingController,
                label: "Body",
                hintText: "please enter body",
                prefixIcon: Icon(Icons.content_paste),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocListener<CreatePostCubit, CreatePostState>(
        listener: (context, state) {
          if (state is CreatePostStateSuccess) {
            context.read<GetAllPostsCubit>().addPost(
              postModel: state.postModel,
            );
            Navigator.pop(context);
          }

          if (state is CreatePostStateError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<CreatePostCubit, CreatePostState>(
          builder: (context, state) {
            if (state is CreatePostStateLoading) {
              return Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              );
            } else {
              return CustomButton(
                text: "Save",
                onTap: () {
                  context.read<CreatePostCubit>().createPost(
                    title: titleTextEditingController.text,
                    body: bodyTextEditingController.text,
                    userId: 1,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
