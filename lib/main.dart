import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_bloc/cubit/create_post_cubit.dart';
import 'package:posts_bloc/cubit/delete_post_cubit.dart';
import 'package:posts_bloc/cubit/get_all_posts_cubit.dart';
import 'package:posts_bloc/cubit/update_post_cubit.dart';
import 'package:posts_bloc/view/screen/list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetAllPostsCubit()..getAllPosts()),
        BlocProvider(create: (context) => CreatePostCubit()),
        BlocProvider(create: (context) => UpdatePostCubit()),
        BlocProvider(create: (context) => DeletePostCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: ListScreen(),
      ),
    );
  }
}
