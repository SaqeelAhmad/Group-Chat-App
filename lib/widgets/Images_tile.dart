

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagestile extends StatefulWidget {
  Imagestile({Key? key//,required this.imageFileLength , this.imageFilePaht
   }) : super(key: key);

  @override
  State<Imagestile> createState() => _ImagestileState();
}

class _ImagestileState extends State<Imagestile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectImages();
  }
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState((){

    });
  }
  //final imageFileLength;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: () {  },child: Icon(Icons.send),),
      body: Column(
        children: [
          Column(
            children: [
              Container(

                color: Colors.white,
                child: Expanded(
                  child: GridView.builder(
                      itemCount: imageFileList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {

                       return Image.file(File(imageFileList![index].path),

                         fit: BoxFit.cover,
                       );
                      }),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
