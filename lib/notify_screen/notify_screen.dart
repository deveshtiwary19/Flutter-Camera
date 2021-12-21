import 'package:assignment/config/color_pallete.dart';
import 'package:flutter/material.dart';


//Following is the screen, that notifies the submission
class NotifyScreen extends StatelessWidget {
  const NotifyScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("GOOD JOB", style: TextStyle(
          color: ColorPalete.colorMain,
          fontWeight: FontWeight.bold,
          fontSize: 50
        ),),
      ),
      
    );
  }
}