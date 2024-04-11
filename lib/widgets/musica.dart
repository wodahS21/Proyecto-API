import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Musica extends StatefulWidget {
  const Musica({super.key});
  @override
  State<Musica> createState() => _MusicaState();
}

class _MusicaState extends State<Musica> {
  AudioPlayer player = AudioPlayer();

  bool playing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }

  Future<void> playm(String path) async {
    await player.play(AssetSource(path));
    setState(() => playing = true);
  }

  Future<void> stopm(String path) async {
    await player.pause();
    setState(() => playing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16, // Ajusta la distancia desde la parte inferior
      right: 16, // Ajusta la distancia desde la derecha
      child: FloatingActionButton(
        backgroundColor: Color.fromARGB(143, 13, 218, 218), // Azul Oscuro

        onPressed: () async {
          if (playing) {
            await stopm('images/RedBlue.mp3');
          } else {
            await playm('images/RedBlue.mp3');
            //await audioPlayer.play(UrlSource('https://www.youtube.com/watch?v=XiV7hwfLXGE'));
          }
        },
        child: Icon(playing
            ? Icons.pause
            : Icons.play_arrow), // Puedes ajustar el icono aquí
      ),
    );
  }
}
