import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turn_it_game/local_storage/local_storage.dart';
import 'package:turn_it_game/providers/score_provider.dart';
import 'package:turn_it_game/screens/menu_screen.dart';

final soundTrackPlayer = AudioPlayer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(ChangeNotifierProvider(
      create: (_) => MainAppProvider()..reset(), child: const MyApp()));
}
// await player.setSourceAsset('audio/soundtrack.mp3');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MainAppProvider>().playBGMusic();
    return const MaterialApp(
      home: MenuScreen(),
    );
  }
}
