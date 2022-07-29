import 'package:flutter/material.dart';
import '../screens/product_overview_screen1.dart';

class AuthForm2 extends StatefulWidget {
  AuthForm2(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  @override
  _AuthFormState2 createState() => _AuthFormState2();
}

class _AuthFormState2 extends State<AuthForm2> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin2 = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin2, context);
      //Navigator.of(context).push(
          //MaterialPageRoute(builder: (context) => ProductsOverviewScreen1()));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: 90.0, bottom: 20.0),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'Eattentials',
                        style: TextStyle(
                          color: Theme.of(context).accentTextTheme.title.color,
                          fontSize: 35,
                          fontFamily: 'Cursive',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email address'),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin2)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'username'),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty ||
                          !value.contains('@123admin') ||
                          value.length < 6) {
                        return 'Please enter a valid password.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'password'),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    child: Text(_isLogin2 ? 'Login' : 'Signup'),
                    onPressed: _trySubmit,
                  ),
                  FlatButton(
                    child: Text(_isLogin2
                        ? 'Create new account'
                        : 'I already have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin2 = !_isLogin2;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
