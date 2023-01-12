import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../service/database_service.dart';
import '../widgets/Images_tile.dart';
import '../widgets/message_tile.dart';
import '../widgets/widgets.dart';
import 'group_info.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;

  const ChatPage(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  File? _image;
  final packer = ImagePicker();

  Future imagegetCamera() async {
    final pickedFile =
        await packer.pickImage(source: ImageSource.camera, imageQuality: 40);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  Future imagegetGallery() async {
    final pickedFile =
        await packer.pickImage(source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(
                    context,
                    GroupInfo(
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                      adminName: admin,
                    ));
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          Padding(padding: EdgeInsets.only(bottom: 70), child: chatMessages()),

          if (imageFileList!.isEmpty)
            const Text('')
          else
            Container(
              color: Colors.grey[700],
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: Colors.grey[700],
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          if (imageFileList != null){
imageFileList == null;
print("test");
                           // imageFileList.value.remove(value);
                            setState(() {

                            });
                          }
                        }, icon: Icon(Icons.clear,color: Colors.white,size: 24,))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: SizedBox(
                      height: 2000,
                      child: GridView.builder(
                          itemCount: imageFileList!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          itemBuilder: (BuildContext context, int index) {
                            return Image.file(
                              File(imageFileList![index].path),
                              fit: BoxFit.cover,
                            );
                          }),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),

          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10, top: 10, right: 5),
              // symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child: Row(children: [
                Expanded(
                    child: GestureDetector(
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Message...",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        border: InputBorder.none,
                        prefixIcon: InkWell(
                            child: Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.deepOrange,
                        ))),
                  ),
                )),
                if (messageController.text.isEmpty && imageFileList!.isEmpty)
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            selectImages();
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.deepOrange,
                          )),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.keyboard_voice,
                          color: Colors.white,
                        )),
                      ),
                    ],
                  )
                else
                  Container(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            sendMessage();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                                child: Icon(
                              Icons.send,
                              color: Colors.white,
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      imagemessage: snapshot.data.docs[index]['image'],
                      time: snapshot.data.docs[index]['time'].toString(),
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: widget.userName ==
                          snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch.toString(),
        "image": "",
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
