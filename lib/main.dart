import 'package:flutter/material.dart';
import 'package:quizzler_flutter/quizBrain.dart';
import 'quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [];
  int score = 0;

  void checkAnswer(bool answerPicked) {
    bool answer = quizBrain.getAnswer();

    if (answerPicked == answer) {

      setState(
        () {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );

          score++;

          quizBrain.nextQuestion();
          if (quizBrain.questionNumber == 12) {
            Alert(
              context: context,
              type: AlertType.error,
              title: "ALERT",
              desc: "You have reached the end of the quiz your score is $score/13",
              buttons: [
                DialogButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    setState(
                      () {
                        Navigator.pop(context);
                        quizBrain.questionNumber = 0;
                        score = 0;
                        scoreKeeper.clear();
                        quizBrain.nextQuestion();
                      },
                    );
                  },
                  width: 120,
                )
              ],
            ).show();
          }
          ;
        },
      );
    } else {
      setState(
        () {
          scoreKeeper.add(
            Icon(
              Icons.clear,
              color: Colors.red,
            ),
          );
          quizBrain.nextQuestion();
          if (quizBrain.questionNumber == 12) {
            Alert(
              context: context,
              type: AlertType.error,
              title: "ALERT",
              desc: "You have reached the end of the quiz your score is $score/13",
              buttons: [
                DialogButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    setState(
                      () {

                        Navigator.pop(context);
                        quizBrain.questionNumber = 0;
                        score = 0;
                        scoreKeeper.clear();

                        quizBrain.nextQuestion();
                      },
                    );
                  },
                  width: 120,
                )
              ],
            ).show();
          }
          ;
        },
      );
    }
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
                quizBrain.getQuestion(),
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
          //True button
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
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
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          //False button
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
