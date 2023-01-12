import 'package:flutter/material.dart';



class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      textDirection: TextDirection.rtl,
                      fit: StackFit.loose,
                      clipBehavior: Clip.hardEdge,
                      children: [
                        Container(
                          padding: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 3,color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: ClipOval(
                            child: Image.asset('assets/images/profile1.png',fit: BoxFit.cover,width: 50,height: 50,),
                          ),),
                        InkWell(
                          onTap: (){},
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: Colors.black,width: 1,),color: Colors.green),
                            child:Center(
                                child: Icon(Icons.add,color: Colors.white,)
                            ) ,),
                        )
                      ],
                    ),
                    Padding(padding:EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("My Status",style: TextStyle(color: Colors.white,fontSize: 18),),
                            SizedBox(height: 5,),
                            Text("Top to add status update",style:  TextStyle(color: Colors.blueGrey),)
                          ],))
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text("Recent Updates",style: TextStyle(color: Colors.white),),
              SizedBox(height: 15,),
              for (int i = 1; i < 7 ; i++)
                Container(padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3,color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: ClipOval(
                          child: Image.asset('assets/images/profile1.png',fit: BoxFit.cover,width: 50,height: 50,),
                        ),),
                      Padding(padding:EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name",style: TextStyle(color: Colors.white,fontSize: 18),),
                              SizedBox(height: 5,),
                              Text("Today, 12:12AM",style:  TextStyle(color: Colors.blueGrey),)
                            ],))

                    ],
                  ),),


            ],
          ),
        ),
      ),
    );
  }
}
