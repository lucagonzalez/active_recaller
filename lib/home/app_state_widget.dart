import 'package:flutter/cupertino.dart';
import 'package:activerecaller/settings/app_preferences.dart';

class AppStateWidget extends InheritedWidget {
  bool isPathHelperEnabled;
  PathStyle pathStyle;

  AppStateWidget({Key key, @required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppStateWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateWidget>();
  }
}
