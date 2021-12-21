import 'package:assignment/home_screen/share_meal_btn.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Getting teh screen size (To get teh screen size and width)
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //The sized box, just to leave empty space
          SizedBox(
            width: double.infinity,
            height: size.height * 0.82,
          ),

          //Following is the widget for shre meal button
          ShareMealButton(size: size, context: context,),
        ],
      ),
    );
  }
}
