import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  Widget _buildRegisterTab() {
    return new Container();
  }

  Widget _buildLoginTab() {
    return new Container();
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
            children: [_buildRegisterTab(), _buildLoginTab()],
          )),
    );
  }
}
