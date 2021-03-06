import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet/authentication/navigate_auth_screen.dart';
import 'package:fleet/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  bool dataIsThere = false;
  TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userdoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username = userdoc['username'];
      dataIsThere = true;
    });
  }

  editProfile() async {
    userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'username': usernameController.text});
    setState(() {
      username = usernameController.text;
    });
    Navigator.pop(context);
  }

  openEditProfileDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: usernameController,
                      style: myStyle(18, Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Update Username',
                          labelStyle: myStyle(
                            16,
                            Colors.grey,
                          )),
                    ),
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () => editProfile(),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.cherry),
                      ),
                      child: Center(
                        child: Text(
                          'Update Now!',
                          style: myStyle(17, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: dataIsThere == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2 - 64,
                    top: MediaQuery.of(context).size.height / 3.1,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper.png'),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Text(
                        username,
                        style: myStyle(35, Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () => openEditProfileDialog(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: GradientColors.cherry),
                          ),
                          child: Center(
                            child: Text(
                              'Edit Profile',
                              style: myStyle(17, Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async{
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => NavigateAuthScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: GradientColors.cherry),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Out',
                              style: myStyle(17, Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
