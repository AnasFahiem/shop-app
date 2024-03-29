import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/auth_screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/products_overview_screen.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    "email": "",
    "password": "",
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print(_authData["email"]);
    print(_authData["password"]);
    if (_authMode == AuthMode.Login) {
      await Provider.of<Auth>(context, listen: false).login(
        _authData["email"],
        _authData["password"],
      );
      Navigator.of(context).pushNamed(ProductsOverviewScreen.routeName);
      // Log user in
    } else {
      // Sign user up
      await Provider.of<Auth>(context, listen: false).signup(
        _authData["email"],
        _authData["password"],
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "E-Mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains("@")) {
                      return "Invalid email!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData["email"] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return "Password is too short!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData["password"] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: "Confirm Password"),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return "Passwords do not match!";
                            }
                            return null;
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child:
                        Text(_authMode == AuthMode.Login ? "LOGIN" : "SIGN UP"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      textStyle: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .labelLarge
                            .color, // Text color
                      ),
                    ),
                  ),
                TextButton(
                  child: Text(
                      "${_authMode == AuthMode.Login ? "SIGNUP" : "LOGIN"} INSTEAD"),
                  onPressed: _switchAuthMode,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                    textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
