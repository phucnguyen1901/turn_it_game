import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:turn_it_game/local_storage/local_storage.dart';
import 'package:turn_it_game/main.dart';

class MainAppProvider extends ChangeNotifier {
  int _score = 0;

  int get score => _score;
  int timePlayed = 0;

  String textNewBestScore = "";

  double effectVolume = 1;
  double bgVolume = 1;

  init() {
    _score = LocalStorage.getBestScore;
    bgVolume = LocalStorage.getBGVolume;
    effectVolume = LocalStorage.getEffectVolume;
    timePlayed = LocalStorage.timePlayed;
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

  setBGVolume(double value) async {
    bgVolume += value;
    if (bgVolume <= 0) {
      bgVolume = 0;
    } else if (bgVolume >= 1) {
      bgVolume = 1;
    }

    await soundTrackPlayer.setVolume(bgVolume);
    await LocalStorage.setBgVolume(bgVolume);
  }

  setEffectVolume(double value) async {
    effectVolume += value;
    if (effectVolume <= 0) {
      effectVolume = 0;
    } else if (effectVolume >= 1) {
      effectVolume = 1;
    }
    print("effect volume $effectVolume");
    await LocalStorage.setEffectVolume(effectVolume);
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
    timePlayed++;
    await LocalStorage.setTimePlayed(timePlayed + 1);
  }

  playBGMusic() {
    soundTrackPlayer.play(AssetSource('audio/soundtrack.mp3'));
    soundTrackPlayer.setReleaseMode(ReleaseMode.loop);
    soundTrackPlayer.setVolume(bgVolume);
    notifyListeners();
  }
}
