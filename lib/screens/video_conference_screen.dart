import 'package:fleet/variables.dart';
import 'package:fleet/videoConference/create_meeting.dart';
import 'package:fleet/videoConference/join_meeting.dart';
import 'package:flutter/material.dart';

class VideoConferenceScreen extends StatefulWidget {
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  buildTab(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        elevation: 7.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            name,
            style: myStyle(15, Colors.black, FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text(
          'FLEET',
          style: myStyle(20, Colors.white, FontWeight.w700),
        ),
        bottom: TabBar(
          // whenever we use tabBar--> we have to mark the state --> "with SingleTickerProviderStateMixin"
          controller: tabController,
          tabs: [
            buildTab('Join Meeting'),
            buildTab('Create Meeting'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          JoinMeeting(),
          CreateMeeting(),
        ],
      ),
    );
  }
}
