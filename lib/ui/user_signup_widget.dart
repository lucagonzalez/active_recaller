import 'package:activerecaller/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:activerecaller/home/landing_widget.dart';
import 'package:getflutter/getflutter.dart';

import '../persistance/database.dart';
import '../persistance/db/user.dart';

class UserSignUpWidget extends StatefulWidget {
  @override
  _UserSignUpWidgetState createState() => _UserSignUpWidgetState();
}

class _UserSignUpWidgetState extends State<UserSignUpWidget> {
  final userNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameTextController.dispose();
    lastNameTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 50),
              child: Column(children: <Widget>[
                Image.asset('assets/images/ActiveRecaller_whiteBg.png'),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: TextFormField(
                    controller: userNameTextController,
                    decoration: InputDecoration(labelText: 'Enter Name'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: TextFormField(
                    controller: lastNameTextController,
                    decoration: InputDecoration(labelText: 'Enter Last Name'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 30),
                  child: TextFormField(
                    controller: emailTextController,
                    decoration: InputDecoration(labelText: 'Enter Email'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: GFButton(
                    shape: GFButtonShape.pills,
                    blockButton: true,
                    type: GFButtonType.outline,
                    child: Text("Sign Up"),
                    onPressed: () async {
                      var db = DB.instance.database;
                      User user = User.createNew(
                          userNameTextController.value.text,
                          lastNameTextController.value.text,
                          emailTextController.value.text);

                      db.userDao.insertUser(user);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreenWidget()));
                    },
                  ),
                ),
                SizedBox(height: 15.0),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
