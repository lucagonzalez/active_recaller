
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:activerecaller/persistance/database.dart';
import 'package:activerecaller/persistance/db/user.dart';

abstract class DbWidgetState<T extends StatefulWidget> extends State<T> {
  var loaded = false;
  User currentUser;

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return buildLoaded(context);
    } else {
      return DB.loading();
    }
  }

  Future<void> initStateAsync(AppDatabase database);

  Widget buildLoaded(BuildContext context);

  @override
  void initState() {
    super.initState();
    initStateAndReload();
  }

  void initStateAndReload() async {
    var database = await DB.instance.getDatabase();
    currentUser = await database.userDao.findCurrentUser();
    await initStateAsync(database);
    setState(() {
      loaded = true;
    });
  }
}

