import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static Future<void> saveLastPausedPosition(String videoPath, int position) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_paused_position_$videoPath', position);
  }

  static Future<int> getLastPausedPosition(String videoPath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('last_paused_position_$videoPath') ?? 0;
  }


}
