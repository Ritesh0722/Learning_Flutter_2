import 'package:flutter/material.dart';
import 'package:quizzler/resultPage.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/resultPage': (context) => ResultPage(),
      },
    );
  }
}

// Global variables
QuizBrain quizBrain = QuizBrain();
List<Icon> scoreKeeper = [];
bool answerCheck;

bool checkAnswer(bool userAnswer) {
  if (userAnswer == quizBrain.getCorrectAnswer()) {
    return true;
  } else {
    return false;
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void updateScorekeeper(bool result) {
    setState(() {
      if (quizBrain.isFinished()) {
        Alert(
                context: context,
                title: "Quizzler",
                desc: "You've reached the last question of the quiz")
            .show();
        quizBrain.reset();
        scoreKeeper.clear();
      } else {
        if (result) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
            size: 25.0,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
            size: 25.0,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: MaterialButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                answerCheck = checkAnswer(true);
                updateScorekeeper(answerCheck);
                quizBrain.isFinished();
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: MaterialButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                answerCheck = checkAnswer(false);
                updateScorekeeper(answerCheck);
                quizBrain.isFinished();
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
