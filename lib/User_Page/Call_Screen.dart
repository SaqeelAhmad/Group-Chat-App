import 'package:flutter/material.dart';


class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,

      child: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(IconData(0xe380, fontFamily: 'MaterialIcons',),color: Colors.white,),
                    ),
                    Padding(padding: EdgeInsets.only(left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Create call link",style: TextStyle(
                                fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white
                            ),),
                            Text ("Share a link for your WhatsApp call",style: TextStyle(color: Colors.blueGrey),),
                          ],
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text('Recent',style: TextStyle(color: Colors.blueGrey,),),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [

                    ClipOval(child: Image.asset("assets/images/profile1.png",width: 50,height: 50,fit: BoxFit.contain,),),
                    Padding(padding: EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name",style: TextStyle(color: Colors.white,fontSize: 18),),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.call_made,color: Colors.green,size: 15,),
                              Text('November 19,2:52 PM',style: TextStyle(color: Colors.blueGrey),),
                            ],
                          ),
                        ],
                      ),),
                    Spacer(),
                    Icon(Icons.call,color: Colors.green),


                  ],
                ),
              )
            ],
          ),),
      ),

    );
  }
}
