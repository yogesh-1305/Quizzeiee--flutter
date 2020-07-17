import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_questions.dart';

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
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> iconList = [];
  QuizQuestions quizQuestions = QuizQuestions();
  int questionNumber = 0;

  // FUNCTION TO SET THE RIGHT OR WRONG ICON
  void setIcon(bool b) {
    if (quizQuestions.getAnswer(questionNumber) == b) {
      iconList.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      iconList.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }

  // FUNCTION TO CHECK FOR LIST INDEX OUT OF BOUND
  void checkForListLength() {
    if (questionNumber >= quizQuestions.length() - 1) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "All Questions Done!",
        desc: "You've reached the end of the questions!",
        buttons: [
          DialogButton(
            color: Colors.teal,
            child: Text(
              'Play Again?',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
             setState(() {
                questionNumber = 0;
                iconList = [];
              });
              Navigator.pop(context);
            width: 120,
          )
        ],
      ).show();
      questionNumber = 0;
      iconList = [];
    } else {
      questionNumber++;
    }
  }

  Expanded checkButtons(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          textColor: Colors.white,
          color: color,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            setIcon(true);
            setState(() {
              checkForListLength();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // QUESTION DISPLAYING WIDGET
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizQuestions.getQuestionText(questionNumber),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        // TRUE BUTTON WIDGET
        checkButtons('True', Colors.green),
        checkButtons('False', Colors.red),
        Row(
          children: iconList,
        )
      ],
    );
  }
}
