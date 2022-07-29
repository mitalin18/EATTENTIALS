import 'package:eattentials/screens/product_overview_screen1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../widgets/auth_form2.dart';

class AuthScreen1 extends StatefulWidget {
  static const routeName = '/auth1';

  @override
  _AuthScreenState1 createState() => _AuthScreenState1();
}

class _AuthScreenState1 extends State<AuthScreen1> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _loading = false;
      });
    });
  }

  final _auth = FirebaseAuth.instance;
  var _isLoading2 = false;
  void _submitAuthForm2(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading2 = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (authResult != null) {
          FirebaseUser user = authResult.user;
          Firestore.instance
              .collection('users')
              .document()
              .setData({'userid': user.uid, 'email': user.email});
        }
      }
       if (authResult != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductsOverviewScreen1()));
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred,please check your credentials!';
      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading2 = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading2 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromRGBO(200, 220, 220, 1).withOpacity(0.9),
            Color.fromRGBO(0, 255, 255, 1).withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text('Eattentials'),
            ),
            body: Center(
              child: _loading
                  ? CircularProgressIndicator()
                  : Container(
                      child: AuthForm2(
                        _submitAuthForm2,
                        _isLoading2,
                      ),
                    ),
            )));
  }
}
