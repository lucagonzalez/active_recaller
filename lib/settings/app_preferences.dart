import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _PATH_HELPER = "path_helper";
  static const _PATH_STYLE = "path_style";

  Future<void> toggleHelperPaths(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_PATH_HELPER, isEnabled);
  }

  Future<void> setPathStyle(PathStyle pathStyle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_PATH_STYLE, pathStyle.index);
  }

  Future<bool> isPathHelperEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_PATH_HELPER)
        ? prefs.getBool(_PATH_HELPER)
        : false;
  }

  Future<PathStyle> getPathStyle() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_PATH_STYLE)
        ? PathStyle.values[prefs.getInt(_PATH_STYLE)]
        : PathStyle.PRINT;
  }
}

enum PathStyle { PRINT, PRECURSIVE }
