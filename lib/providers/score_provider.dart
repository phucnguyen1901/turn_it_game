import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScoreProvider extends ChangeNotifier {
  int _score = 0;

  int get score => _score;

  void increaseScore() {
    _score++;
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }
}
