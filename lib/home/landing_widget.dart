import 'dart:io';

import 'package:activerecaller/ui/reusable/create_material_color.dart';
import 'package:activerecaller/ui/user_signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:activerecaller/persistance/database.dart';
import 'package:activerecaller/persistance/db/user.dart';
import 'package:activerecaller/settings/app_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'app_state_widget.dart';
import 'main_screen.dart';



class LandingWidget extends StatefulWidget {
  @override
  State createState() => _LandingState();
}

class _LandingState extends State<LandingWidget> {
  bool _isSettingUp = true;
  bool _isPathHelperEnabled;
  PathStyle _pathStyle;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  void _setup() async {
    final appPreferences = AppPreferences();
    _isPathHelperEnabled = await appPreferences.isPathHelperEnabled();
    _pathStyle = await appPreferences.getPathStyle();

    final Directory docDir = await getApplicationDocumentsDirectory();
    File databaseDestination =
    File('${docDir.path}/../databases/app_database.db');

    if (!databaseDestination.existsSync()) {
      final content = await rootBundle.load('assets/initial_database.db');
      await databaseDestination.writeAsBytes(content.buffer.asUint8List());
    }

    setState(() {
      _isSettingUp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appStateWidget = _buildAppStateWidget(context);
    appStateWidget.isPathHelperEnabled = _isPathHelperEnabled;
    appStateWidget.pathStyle = _pathStyle;

    return appStateWidget;
  }

  AppStateWidget _buildAppStateWidget(BuildContext context) {
    return AppStateWidget(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Active Recaller',
          theme: ThemeData(primarySwatch: createMaterialColor(Color(0xff3f72af)), fontFamily: 'LibreFranklin'),
          home: firstScreenDrawer(),
        ));
  }

  Widget firstScreenDrawer() {
    return FutureBuilder<AppDatabase>(
      future: DB.instance.getDatabase(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<List<User>>(
              future: snapshot.data.userDao.findAllUsers(),
              builder: (c, s) {
                if (s.hasData) {
                  if (s.data.isEmpty) {
                    return UserSignUpWidget();
                  } else {
                    return MainScreenWidget();
                  }
                } else {
                  return DB.loading();
                }
              });
        } else {
          return DB.loading();
        }
      },
    );
  }
}
