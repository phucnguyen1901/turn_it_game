import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _prefs;
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setBestScore(int newBestCore) async {
    if (isNewBestCore(newBestCore)) {
      await _prefs.setInt('record', newBestCore);
    }
  }

  static Future<void> setTimePlayed(int timePlayed) async {
    await _prefs.setInt('time-played', timePlayed);
  }

  static Future<void> setBgVolume(double bgVolume) async {
    await _prefs.setDouble('bg-volume', bgVolume);
  }

  static Future<void> setEffectVolume(double effectVolume) async {
    await _prefs.setDouble('effect-volume', effectVolume);
  }

  static get getBestScore {
    int record = _prefs.getInt('record') ?? 0;
    print("Record:$record");
    return record;
  }

  static int get timePlayed {
    int record = _prefs.getInt('time-played') ?? 0;
    return record;
  }

  static double get getBGVolume {
    double record = _prefs.getDouble('bg-volume') ?? 1;
    return record;
  }

  static get getEffectVolume {
    double record = _prefs.getDouble('effect-volume') ?? 1;
    return record;
  }

  static bool isNewBestCore(newBestCore) => newBestCore > getBestScore;
  static get prefs => _prefs;
}
