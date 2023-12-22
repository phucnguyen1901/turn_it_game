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

  static Future<void> setBgVolume(bool volume) async {
    await _prefs.setBool('bg-volume', volume);
  }

  static Future<void> setEffectVolume(bool effectVolume) async {
    await _prefs.setBool('effect-volume', effectVolume);
  }

  static get getBestScore {
    int record = _prefs.getInt('record') ?? 0;
    return record;
  }

  static int get timePlayed {
    int record = _prefs.getInt('time-played') ?? 0;
    return record;
  }

  static bool get getBGVolume {
    bool record = _prefs.getBool('bg-volume') ?? true;
    return record;
  }

  static bool get getEffectVolume {
    bool record = _prefs.getBool('effect-volume') ?? true;
    return record;
  }

  static bool isNewBestCore(newBestCore) => newBestCore > getBestScore;
  static get prefs => _prefs;
}
