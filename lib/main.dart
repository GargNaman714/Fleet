import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet/screens/home_page.dart';
import 'package:fleet/screens/intro_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('${snapshot.error}');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: NavigationPage(),            
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}


class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool isSigned=false;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user!=null){
        setState(() {
          isSigned=true;
        });
      }
      else{
        setState(() {
          isSigned=false;
        });
      }
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSigned==false?IntroAuthScreen():HomePage(),
    );
  }
}