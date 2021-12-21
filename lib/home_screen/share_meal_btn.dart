import 'package:assignment/click_picture/click_picture_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../config/color_pallete.dart';

//Following is the custom widghet for share meal button
class ShareMealButton extends StatelessWidget {
  const ShareMealButton({
    Key? key,
    required this.size,
    required this.context,
  }) : super(key: key);

  //We need the size for adjusting the button according to screen size
  final Size size;
  //WE need the context, as we will be starting a new Activity on click
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //Following code, needs to be executed once the button (Share your meal) is Clicked
        //Pushing the new Activity and finishing the last one

        //Also, we need to check for the avilable cameras to send it further in list
        await availableCameras().then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => ClickPictureScreen(
                        cameras: value,
                      )));
        });
      },
      child: Container(
        width: double.infinity,
        height: size.height * 0.07,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: const BoxDecoration(
            color: ColorPalete.colorMain,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: const Center(
          child: Text(
            'Share your meal',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
