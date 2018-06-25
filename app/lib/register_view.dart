import 'package:app/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;

class RegisterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RegisterViewState();
  }
}

class _RegisterData {
  String name;
  String password;
}

class _LoginData {
  String name;
  String password;
}

class RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  _RegisterData _registerData = new _RegisterData();
  _LoginData _loginData = new _LoginData();

  Widget _buildRegisterTab(context) {
    return Form(
      key: _registerKey,
      child: new Column(
        children: <Widget>[
          new Text("Username"),
          new TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a username';
              }
            },
            onSaved: (value) {
              _registerData.name = value;
            },
          ),
          new Text("Password"),
          new TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a password';
              }
            },
            onSaved: (value) {
              _registerData.password = value;
            },
            obscureText: true,
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: new RaisedButton(
              onPressed: () {
                if (_registerKey.currentState.validate()) {
                  _registerKey.currentState.save();

                  print(_registerData.toString());

                  http
                      .post(globals.BASE_URL +
                          "/register?name=" +
                          _registerData.name +
                          "&password=" +
                          _registerData.password +
                          "&isAdmin=false")
                      .then((response) {
                    final int statusCode = response.statusCode;

                    if (statusCode < 200 || statusCode > 400 || json == null) {
                      throw new Exception("Error while fetching data");
                    }

                    final responseJson = json.decode(response.body);
                    print(responseJson);

                    if (statusCode == 200) {
                      print("Register Successfull!");
                    }
                  }).then((response) {
                    http
                        .get(globals.BASE_URL +
                            "/login?name=" +
                            _registerData.name +
                            "&password=" +
                            _registerData.password +
                            "&isAdmin=false")
                        .then((response) {
                      final int statusCode = response.statusCode;

                      if (statusCode < 200 ||
                          statusCode > 400 ||
                          json == null) {
                        final responseJson = json.decode(response.body);
                        print(statusCode);
                        print(responseJson);
                        throw new Exception("Error while fetching data");
                      }

                      final responseJson = json.decode(response.body);
                      print(responseJson);

                      if (statusCode == 200) {
                        print("Login Successfull!");
                        globals.loggedInUser =
                            ProfileData.fromJson(responseJson);
                        setState(() {
                          print(globals.loggedInUser);
                        });
                        Navigator.pop(context);
                      }
                    });
                  });
                }
              },
              child: new Text('Register'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginTab(context) {
    return Form(
      key: _loginKey,
      child: new Column(
        children: <Widget>[
          new Text("Username"),
          new TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a username';
              }
            },
            onSaved: (value) {
              _loginData.name = value;
            },
          ),
          new Text("Password"),
          new TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a password';
              }
            },
            onSaved: (value) {
              _loginData.password = value;
            },
            obscureText: true,
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: new RaisedButton(
              onPressed: () {
                if (_loginKey.currentState.validate()) {
                  _loginKey.currentState.save();

                  print(_loginData.toString());
                  print(globals.BASE_URL +
                      "/login?name=" +
                      _loginData.name +
                      "&password=" +
                      _loginData.password);
                  http
                      .get(globals.BASE_URL +
                          "/login?name=" +
                          _loginData.name +
                          "&password=" +
                          _loginData.password)
                      .then((response) {
                    final int statusCode = response.statusCode;

                    if (statusCode < 200 || statusCode > 400 || json == null) {
                      print(response);
                      print(statusCode);
                    }

                    if (statusCode == 404 || statusCode == 401) {
                      print("Wrong credentials!");
                      return;
                    }

                    final responseJson = json.decode(response.body);
                    print(responseJson);

                    if (statusCode == 200) {
                      print("Login Successfull!");
                      globals.loggedInUser = ProfileData.fromJson(responseJson);
                      setState(() {
                        print(globals.loggedInUser);
                      });
                      Navigator.pop(context);
                    }
                  });
                }
              },
              child: new Text('Login'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
          appBar: new AppBar(
            bottom: new TabBar(
              tabs: [
                new Tab(
                  icon: new Text("Register"),
                ),
                new Tab(
                  icon: new Text("Login"),
                ),
              ],
            ),
            // title: new Text(viewedSongData.name),
          ),
          body: new TabBarView(
            children: [_buildRegisterTab(context), _buildLoginTab(context)],
          )),
    );
  }
}
