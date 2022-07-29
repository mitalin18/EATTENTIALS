import 'package:eattentials/screens/product_overview_screen1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
import '../screens/auth_screen1.dart';

class LandingScreen extends StatefulWidget {
  @override
  LandingState createState() => LandingState();
}

class LandingState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("EATTENTIALS"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 100.0, height: 70.0),
              ElevatedButton(
                onPressed: () {
                  /*return StreamBuilder(
                      stream: FirebaseAuth.instance.onAuthStateChanged,
                      builder: (ctx, userSnapshot) {
                        if (userSnapshot.hasData) {
                          return ProductsOverviewScreen1();
                        }
                        //return LandingScreen();
                        return AuthScreen1();
                      });*/
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AuthScreen1()));
                },
                child: Text("     ADMIN LOGIN     ",
                    style: TextStyle(fontSize: 20)),
              ),
              SizedBox(width: 100.0, height: 50.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AuthScreen()));
                },
                child: Text("       USER LOGIN       ",
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ));
  }
}
