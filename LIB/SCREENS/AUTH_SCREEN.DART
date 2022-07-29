import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/product_overview_screen.dart';

import 'package:flutter/services.dart';
import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
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
            builder: (context) => ProductsOverviewScreen()));
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
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
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
                      child: AuthForm(
                        _submitAuthForm,
                        _isLoading,
                      ),
                    ),
            )));
  }
}
