import 'dart:io';

import 'package:assignment/config/color_pallete.dart';
import 'package:assignment/custom_common_widgets/back_btn.dart';
import 'package:assignment/notify_screen/notify_screen.dart';
import 'package:camera/camera.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


import '../custom_common_widgets/animal_image.dart';

class ClickPictureScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const ClickPictureScreen({required this.cameras, key}) : super(key: key);

  @override
  State<ClickPictureScreen> createState() => ClickPictureScreenState();
}

class ClickPictureScreenState extends State<ClickPictureScreen> {
  //Teh main camera controller
  late CameraController controller;
  //Teh object to store clicked image in
  XFile? pictureFile;

  late bool pictureTaken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pictureTaken = false;

    //Initializing the controller
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

//Following is the method, that uploads the image to firebase
  Future uploadImageToFirebase(BuildContext context) async {
    var _imageFile = pictureFile!.path;

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child("imageid: " + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(pictureFile!.path));
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //The var for getting the screen height and width
    var size = MediaQuery.of(context).size;

    if (!controller.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //The back button at the top
                CustomBackButton(size: size, context: context),

                //The animal image
                AnimalImage(size: size),
              ],
            ),

            //Teh items to over ride the stack
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: size.height * 0.6,
                decoration: const BoxDecoration(
                  color: ColorPalete.colorSecondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //For leaving some space
                    const SizedBox(
                      height: 30,
                    ),

                    //The Row, with fork, spoon and camera
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //The fork Image
                        Image.asset("assets/images/fork.png"),

                        //Following will be the camera, that we will use to click the Image
                        //The conditioon checks if picture is taken!!
                        //If clicked--> Shows clicked picture
                        //else--> shows the camera preview
                        pictureTaken
                            ? Container(
                                width: size.width * 0.6,
                                height: size.width * 0.6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(120),
                                    topRight: Radius.circular(120),
                                    bottomLeft: Radius.circular(120),
                                    bottomRight: Radius.circular(120),
                                  ),
                                  child: Image.file(
                                    File(
                                      pictureFile!.path,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                width: size.width * 0.6,
                                height: size.width * 0.6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(120),
                                    topRight: Radius.circular(120),
                                    bottomLeft: Radius.circular(120),
                                    bottomRight: Radius.circular(120),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CameraPreview(controller),
                                  ),
                                ),
                              ),

                        //The spoon Image
                        Image.asset("assets/images/spoon.png"),
                      ],
                    ),

                    //For leaving some space
                    const SizedBox(
                      height: 30,
                    ),

                    //The text (That asks to click picture or share/save picture)
                    Text(
                      pictureTaken ? "Will you eat this?" : "Click your meal",
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),

                    //For leaving some space
                    const SizedBox(
                      height: 20,
                    ),

                    //The camera/upload button
                    //Clicks the image from camera
                    //Uploads the image to firebase
                    //Works respectively according to state
                    GestureDetector(
                      onTap: () async {
                        if (pictureTaken) {
                          //Means the picture is taken and we now need to upload it to database

                          uploadImageToFirebase(context);
                          //Pushing the notify activity
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const NotifyScreen()),
                              (route) => false);
                        } else {
                          //Means that we need to click the picture now
                          pictureFile = await controller.takePicture();
                          setState(() {
                            pictureTaken = true;
                          });
                        }
                      },
                      child: Container(
                        width: size.width * 0.15,
                        height: size.width * 0.15,
                        decoration: const BoxDecoration(
                          color: ColorPalete.colorMain,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            pictureTaken ? Icons.done : Icons.photo_camera,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
