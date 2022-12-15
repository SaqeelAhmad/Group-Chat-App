import 'package:chatapp/User_Page/About_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/helper_function.dart';
import '../pages/auth/login_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../service/auth_service.dart';
import '../service/database_service.dart';
import '../widgets/widgets.dart';
import 'Call_Screen.dart';
import 'Chats_Screen.dart';

import 'Status_Screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  late final selectedItem ;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        drawer: Drawer(
            child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              userName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.home),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreenReplace(
                    context,
                    ProfilePage(
                      userName: userName,
                      email: email,
                    ));
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutPage()));
              },
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "About",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        )),
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text("Chat App"),
          actions: [
            IconButton(
                onPressed: () {
                  nextScreen(context, const SearchPage());
                },
                icon: const Icon(
                  Icons.search,
                )),
            PopupMenuButton(onSelected: (value) {
              setState(() {
                print(value);
                switch (value){
                  case 1: {selectedItem = popUpDialog(context);}
                    break;
                  case 2:{selectedItem = value;}
                    break;
                  case 3:{selectedItem = value;}
                  break;
                  case 4:{selectedItem = value;}
                  break;
                }

              });

              Navigator.pushNamed(context, value.toString());
            }, itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                    value: 1,
                    // ( //popUpDialog(context);
                    //     popUpDialog(context); ),
                    child: Text(
                      "New Group",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    )),
                 PopupMenuItem(
                    value: 2,
                    child: Text(
                      "New broadcast",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    )),
                 PopupMenuItem(
                    value: 3,
                    child: Text(
                      "Linked devices",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    )),
                PopupMenuItem(
                    value: 4,
                    child: Text(
                      "Starred messages",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    )),
                PopupMenuItem(
                    value: 5,
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ))
              ];
            })
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.deepOrange,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 4,
                labelStyle:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                tabs: [
                  // tab 1
                  const SizedBox(
                    width: 25,
                    child: Tab(
                      icon: Icon(Icons.camera_alt),
                    ),
                  ),
                  // tab 2
                  SizedBox(
                    width: 85,
                    child: Row(
                      children: [
                        const Text(
                          "CHATS",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "10",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // tab 3
                  SizedBox(
                    width: 70,
                    child: Row(
                      children: const [
                        Text(
                          "STATUS",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  // tab 4

                  Row(
                    children: const [
                      Text(
                        "CALLS",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: TabBarView(
                  children: [
                    // --------------------- tab 1 Camera -------------------------------------
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black,
                    ),
//------------------------------------ tab 2 Chats ---------------------------------------
                    const ChatsScreen(),
// ----------------------------------- tab 3 Status --------------------------------------
                    const StatusScreen(),
                    // ------------------ tab 4 Calls   -----------------------
                    const CallScreen(),
                  ],
                ))
          ],
        ),
      ),
    );
  }
  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a group",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  )
                      : TextField(
                    onChanged: (val) {
                      setState(() {
                        groupName = val;
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (groupName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      DatabaseService(
                          uid: FirebaseAuth.instance.currentUser!.uid)
                          .createGroup(userName,
                          FirebaseAuth.instance.currentUser!.uid, groupName)
                          .whenComplete(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pop();
                      showSnackbar(
                          context, Colors.green, "Group created successfully.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text("CREATE"),
                )
              ],
            );
          }));
        });
  }
}
