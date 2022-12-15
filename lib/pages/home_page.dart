// import 'package:chatapp/pages/profile_page.dart';
// import 'package:chatapp/pages/search_page.dart';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../helper/helper_function.dart';
// import '../service/auth_service.dart';
// import '../service/database_service.dart';
// import '../widgets/group_tile.dart';
// import '../widgets/widgets.dart';
// import 'auth/login_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//
//       body: groupList(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           popUpDialog(context);
//         },
//         elevation: 0,
//         backgroundColor: Theme.of(context).primaryColor,
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//           size: 30,
//         ),
//       ),
//     );
//   }
//
//   popUpDialog(BuildContext context) {
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: ((context, setState) {
//             return AlertDialog(
//               title: const Text(
//                 "Create a group",
//                 textAlign: TextAlign.left,
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _isLoading == true
//                       ? Center(
//                           child: CircularProgressIndicator(
//                               color: Theme.of(context).primaryColor),
//                         )
//                       : TextField(
//                           onChanged: (val) {
//                             setState(() {
//                               groupName = val;
//                             });
//                           },
//                           style: const TextStyle(color: Colors.black),
//                           decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Theme.of(context).primaryColor),
//                                   borderRadius: BorderRadius.circular(20)),
//                               errorBorder: OutlineInputBorder(
//                                   borderSide:
//                                       const BorderSide(color: Colors.red),
//                                   borderRadius: BorderRadius.circular(20)),
//                               focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Theme.of(context).primaryColor),
//                                   borderRadius: BorderRadius.circular(20))),
//                         ),
//                 ],
//               ),
//               actions: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor),
//                   child: const Text("CANCEL"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (groupName != "") {
//                       setState(() {
//                         _isLoading = true;
//                       });
//                       DatabaseService(
//                               uid: FirebaseAuth.instance.currentUser!.uid)
//                           .createGroup(userName,
//                               FirebaseAuth.instance.currentUser!.uid, groupName)
//                           .whenComplete(() {
//                         _isLoading = false;
//                       });
//                       Navigator.of(context).pop();
//                       showSnackbar(
//                           context, Colors.green, "Group created successfully.");
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor),
//                   child: const Text("CREATE"),
//                 )
//               ],
//             );
//           }));
//         });
//   }
//
//   groupList() {
//     return StreamBuilder(
//       stream: groups,
//       builder: (context, AsyncSnapshot snapshot) {
//         // make some checks
//         if (snapshot.hasData) {
//           if (snapshot.data['groups'] != null) {
//             if (snapshot.data['groups'].length != 0) {
//               return ListView.builder(
//                 itemCount: snapshot.data['groups'].length,
//                 itemBuilder: (context, index) {
//                   int reverseIndex = snapshot.data['groups'].length - index - 1;
//                   return GroupTile(
//                       groupId: getId(snapshot.data['groups'][reverseIndex]),
//                       groupName: getName(snapshot.data['groups'][reverseIndex]),
//                       userName: snapshot.data['fullName']);
//                 },
//               );
//             } else {
//               return noGroupWidget();
//             }
//           } else {
//             return noGroupWidget();
//           }
//         } else {
//           return Center(
//             child: CircularProgressIndicator(
//                 color: Theme.of(context).primaryColor),
//           );
//         }
//       },
//     );
//   }
//
//   noGroupWidget() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {
//               popUpDialog(context);
//             },
//             child: Icon(
//               Icons.add_circle,
//               color: Colors.grey[700],
//               size: 75,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           const Text(
//             "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
//             textAlign: TextAlign.center,
//           )
//         ],
//       ),
//     );
//   }
// }
