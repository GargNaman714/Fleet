import 'package:fleet/variables.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:fleet/authentication/navigate_auth_screen.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "HOLA!",
          body: "Welcome to FLEET, the best video conferencing app",
          image: Center(
            child: Image.asset(
              'images/welcome.png',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black,FontWeight.w300,),
            titleTextStyle: myStyle(20, Colors.black),
          ),
        ),
        PageViewModel(
          title: "JOIN or HOST MEETINGS",
          body: "Easy to use interface, join or host meetings instantly for free",
          image: Center(
            child: Image.asset(
              'images/conference.png',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black,FontWeight.w300,),
            titleTextStyle: myStyle(20, Colors.black),
          ),
        ),
        PageViewModel(
          title: "SECURITY",
          body: "Your security is our priority. Our servers are completely secure and reliable",
          image: Center(
            child: Image.asset(
              'images/secure.jpg',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black,FontWeight.w300),
            titleTextStyle: myStyle(20, Colors.black),
          ),
        ),
      ],
      onDone: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigateAuthScreen()));

      },
      onSkip: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigateAuthScreen()));
      },
      showSkipButton: true,
      skip: const Icon(Icons.skip_next),
      next:const Icon(Icons.arrow_forward_ios),
      done: Text("Done",style: myStyle(20,Colors.black),),
    );
  }
}
