import 'package:flutter/material.dart';

import '../config/color_pallete.dart';

//Following is the custom widget, that is responsible for rendering a Back Button on the top of teh screen
//Following button, takes buil context and closes the current activity on click
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
    required this.size,
    required this.context,
  }) : super(key: key);

  final Size size;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Closing the current activity
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 35, left: 15),
        height: size.width * 0.13,
        width: size.width * 0.13,
        decoration: const BoxDecoration(
          color: ColorPalete.colorMain,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }
}
