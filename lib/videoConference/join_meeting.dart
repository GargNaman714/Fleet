import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  String username = '';

  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userdoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username = userdoc['username'];
    });
  }

  joinMeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featureflags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };
      if (Platform.isAndroid) {
        featureflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureflags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions(room: roomController.text)
        ..userDisplayName =
            nameController.text == '' ? username : nameController.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureflags);

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Room Code',
                  style: myStyle(20),
                ),
                SizedBox(height: 20),
                PinCodeTextField(
                  controller: roomController,
                  appContext: context,
                  length: 6,
                  autoDisposeControllers: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                  animationDuration: Duration(milliseconds: 300),
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: nameController,
                  style: myStyle(20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name(optional)',
                    labelStyle: myStyle(15),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                CheckboxListTile(
                  value: isVideoMuted,
                  onChanged: (value) {
                    setState(() {
                      isVideoMuted = value!;
                    });
                  },
                  title: Text(
                    'Video Muted',
                    style: myStyle(18, Colors.black),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                CheckboxListTile(
                  value: isAudioMuted,
                  onChanged: (value) {
                    setState(() {
                      isAudioMuted = value!;
                    });
                  },
                  title: Text(
                    'Audio Muted',
                    style: myStyle(18, Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Of course, you can customise your settings in the meeting",
                  style: myStyle(15,Colors.blueGrey,FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  height: 48,
                  thickness: 2.0,
                ),
                InkWell(
                  onTap: () => joinMeeting(),
                  child: Container(
                    width: double.maxFinite,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: GradientColors.facebookMessenger),
                    ),
                    child: Center(
                      child: Text(
                        "Join Meeting",
                        style: myStyle(20, Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
