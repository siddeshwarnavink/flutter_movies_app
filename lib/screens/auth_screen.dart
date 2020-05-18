import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/http_exception.dart';
import '../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  static String routeName = '/auth';

  final bool needRedirect;
  AuthScreen([this.needRedirect = false]);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An error occured!'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(ctx).pop(),
                )
              ],
            ));
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_isLogin) {
        await Provider.of<AuthProvider>(context, listen: false)
            .signin(_authData['email'], _authData['password']);
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .signup(_authData['email'], _authData['password']);
      }
      if (widget.needRedirect) {
        Navigator.of(context).pushReplacementNamed('/');
      }
    } on HttpException catch (err) {
      var errorMessage = 'Authenticate failed!';
      if (err.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email already in use!';
      } else if (err.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address.';
      } else if (err.toString().contains('WEEK_PASSWORD')) {
        errorMessage = 'This password is too week.';
      } else if (err.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Chould not find user with that email!';
      } else if (err.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      _showErrorDialog(errorMessage);
    } catch (err) {
      const errorMessage = 'Chould not authenticate you. Please try later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Authenticate'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        _isLogin ? ' Sign in' : 'Create account',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'E-Mail'),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return 'Invalid email!';
                                  }
                                },
                                onSaved: (value) {
                                  _authData['email'] = value;
                                },
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                                obscureText: true,
                                focusNode: _passwordFocusNode,
                                textInputAction: TextInputAction.send,
                                onFieldSubmitted: (val) => _submit,
                                onSaved: (value) {
                                  _authData['password'] = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty || value.length < 5) {
                                    return 'Password is too short!';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RaisedButton(
                                child: Text(_isLogin ? 'LOGIN' : 'SIGN UP'),
                                onPressed: _submit,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 8.0),
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context)
                                    .primaryTextTheme
                                    .button
                                    .color,
                              ),
                              FlatButton(
                                child: Text(
                                    '${_isLogin ? 'SIGNUP' : 'SIGNIN'} INSTEAD'),
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 4),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                textColor: Theme.of(context).primaryColor,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
