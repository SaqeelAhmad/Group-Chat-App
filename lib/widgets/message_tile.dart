import 'package:flutter/material.dart';

import '../Utility/utility.dart';

class MessageTile extends StatefulWidget {
  final String time ;
  final String message;
  final String sender;
  final String imagemessage;
  final bool sentByMe;

  const MessageTile(
      {Key? key,
        required this.time,
      required this.message,
      required this.sender,
        required this.imagemessage,
      required this.sentByMe})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {

  @override
  Widget build(BuildContext context) {

    
    return Container(
      
      child: Container(
        padding: EdgeInsets.only(
            top: 4,
            bottom: 4,
            left: widget.sentByMe ? 0 : 24,
            right: widget.sentByMe ? 24 : 0),
        alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: widget.sentByMe
              ? const EdgeInsets.only(left: 30)
              : const EdgeInsets.only(right: 30),
          padding:
              const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: widget.sentByMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
              color: widget.sentByMe
                  ? Theme.of(context).primaryColor
                  : Colors.grey[700]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Utility.getHumanReadableDate(widget.time),style: TextStyle(color: Colors.white),),
              SizedBox(height: 5,),

              Text(
                widget.sender.toUpperCase(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5),
              ),
              const SizedBox(
                height: 8,
              ),

             if (widget.imagemessage.isEmpty  ) Text("",style: TextStyle(fontSize: 0.111111111),)
             else Container(height: 50,width: 50,color: Colors.blue,),


              Text(widget.message,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 16, color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
  
}




