import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_bloc/cubit/get_all_posts_cubit.dart';
import 'package:posts_bloc/cubit/update_post_cubit.dart';
import 'package:posts_bloc/model/post_model.dart';
import 'package:posts_bloc/state/update_post_state.dart';
import 'package:posts_bloc/view/widget/custom_button.dart';
import 'package:posts_bloc/view/widget/custom_text_field.dart';

class UpdatePostScreen extends StatelessWidget {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController bodyTextEditingController = TextEditingController();
  PostModel postModel;
  int index;

  UpdatePostScreen({super.key, required this.postModel, required this.index}) {
    titleTextEditingController.text = postModel.title ?? "";
    bodyTextEditingController.text = postModel.title ?? "";
  }

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
      bottomNavigationBar: BlocListener<UpdatePostCubit, UpdatePostState>(
        listener: (context, state) {
          if (state is UpdatePostStateSuccess) {
            context.read<GetAllPostsCubit>().updatePost(
              postModel: state.postModel,
              index: index,
            );
            Navigator.pop(context);
          }

          if (state is UpdatePostStateError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<UpdatePostCubit, UpdatePostState>(
          builder: (context, state) {
            if (state is UpdatePostStateLoading) {
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
                  context.read<UpdatePostCubit>().updatePost(
                    title: titleTextEditingController.text,
                    body: bodyTextEditingController.text,
                    userId: postModel.userId!,
                    id: postModel.id!,
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
