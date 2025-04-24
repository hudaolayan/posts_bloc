import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final GestureTapCallback? onTap;

  const CustomButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
        height: 50,
        width: double.infinity,
        child: Text(text),
      ),
    );
  }
}
