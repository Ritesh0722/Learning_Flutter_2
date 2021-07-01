import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Function returning expanded container widget as a button to play different audi notes
    Widget playSound({String audioTrack, Color getColor}) {
      return Expanded(
        child: MaterialButton(
          color: getColor,
          enableFeedback: false,
          onPressed: () {
            final player = AudioCache();
            player.play('$audioTrack');
          },
          child: SizedBox(),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                playSound(audioTrack: 'note1.wav', getColor: Colors.red),
                playSound(audioTrack: 'note2.wav', getColor: Colors.orange),
                playSound(audioTrack: 'note3.wav', getColor: Colors.yellow),
                playSound(audioTrack: 'note4.wav', getColor: Colors.green),
                playSound(audioTrack: 'note5.wav', getColor: Colors.blue),
                playSound(audioTrack: 'note6.wav', getColor: Colors.indigo),
                playSound(audioTrack: 'note7.wav', getColor: Colors.purple),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
