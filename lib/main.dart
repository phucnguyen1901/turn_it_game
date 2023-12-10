import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turn_it_game/providers/score_provider.dart';
import 'package:turn_it_game/screens/menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlameAudio.bgm.play('soundtrack.mp3');
  runApp(ChangeNotifierProvider(
      create: (_) => ScoreProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MenuScreen(),
    );
  }
}
