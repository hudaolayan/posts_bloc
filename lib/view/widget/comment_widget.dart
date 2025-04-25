import 'package:flutter/cupertino.dart';
import 'package:posts_bloc/model/comment_model.dart';

class CommentWidget extends StatelessWidget {
  CommentModel commentModel;

  CommentWidget({super.key, required this.commentModel});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          commentModel.name.toString(),
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),
        ),
        Text(
          commentModel.email.toString(),
          style: TextStyle( fontSize: 12.0),
        ),
        Text(
          commentModel.body.toString(),
          style: TextStyle( fontSize: 14.0),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}
