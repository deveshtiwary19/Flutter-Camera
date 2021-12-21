
import 'package:flutter/material.dart';

//Following is the common widget that renders Animal Image in the top centre of the screen
class AnimalImage extends StatelessWidget {
  const AnimalImage({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: size.height * 0.35,
      child: Image.asset("assets/images/babyS.png"),
    );
  }
}
