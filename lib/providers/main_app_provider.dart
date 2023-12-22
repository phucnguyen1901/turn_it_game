import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:turn_it_game/local_storage/local_storage.dart';
import 'package:turn_it_game/main.dart';

class MainAppProvider extends ChangeNotifier {
  int _score = 0;

  int get score => _score;

  String textNewBestScore = "";

  bool effectVolume = true;
  bool musicVolume = true;

  bool isFirstTimePlayBG = false;

  init() {
    _score = LocalStorage.getBestScore;
    effectVolume = LocalStorage.getEffectVolume;
    musicVolume = LocalStorage.getBGVolume;
  }

  void increaseScore() {
    _score++;
    textNewBestScore = "SCORE $score";
    notifyListeners();
  }

  void reset() {
    _score = 0;
    textNewBestScore = "SCORE 0";
    setTimePlayed();
    notifyListeners();
  }

  setEffectVolume(bool value) async {
    effectVolume = value;
    await LocalStorage.setEffectVolume(value);
    notifyListeners();
  }

  void recordBestCore() async {
    final isNewBestCore = LocalStorage.isNewBestCore(score);
    await LocalStorage.setBestScore(score);
    if (isNewBestCore) {
      textNewBestScore = "RECORD $score";
    } else {
      textNewBestScore = "SCORE $score";
    }
    notifyListeners();
  }

  setTimePlayed() async {
    await LocalStorage.setTimePlayed(LocalStorage.timePlayed + 1);
  }

  playBGMusic() async {
    soundTrackPlayer.play(AssetSource('audio/soundtrack.mp3'));
    soundTrackPlayer.setReleaseMode(ReleaseMode.loop);
    if (isFirstTimePlayBG) {
      isFirstTimePlayBG = true;
      await LocalStorage.setEffectVolume(musicVolume);
    } else {
      await LocalStorage.setEffectVolume(true);
      musicVolume = true;
    }

    notifyListeners();
  }

  stopBGMusic() async {
    print("stop bg");
    await soundTrackPlayer.stop();
    await LocalStorage.setEffectVolume(false);
    musicVolume = false;
    notifyListeners();
  }
}
