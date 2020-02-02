
import 'package:flutter/material.dart';
//import 'package:quiz_app/question.dart';
import 'package:quiz_app/question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

QuestionBrain questionBrain = new QuestionBrain();


class MyApp extends StatelessWidget {

  // This widget is the root of your application.

  @override

  Widget build(BuildContext context) {

    return MaterialApp(
debugShowCheckedModeBanner: false,
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


  List<Icon>scoreKeeper =[
];
  int Score=0;

  void checkAnswer(bool userAnswer)
  {
    setState(() {
      if (questionBrain.isFinish())
        {
          Alert(context: context,
              title: "All questions are completed",
          desc: "you have scored $Score right question")
          .show();
          Score = 0;
          questionBrain.reset();
          scoreKeeper.clear();
        }
     else
       {
         if(questionBrain.getAnswerResult() == userAnswer){
           scoreKeeper.add(
               Icon(
                 Icons.check_box,
                 color: Colors.green,
                 size: 24,
               )
           );
           Score++;
         }
         else{
           scoreKeeper.add(
               Icon(
                 Icons.close,
                 color: Colors.red,
                 size: 24,
               )
           );


         }

         questionBrain.nextQuestion();
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

               questionBrain.getQuestionText(),

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

            padding: EdgeInsets.all(10.0),

            child: FlatButton(

              color: Colors.green,

              child: Text(

                "True",

                style: TextStyle(

                  fontSize: 20.0,

                  color: Colors.white,

                ),

              ),

              onPressed: () {
                checkAnswer(true);
              },

            ),

          ),

        ),

        Expanded(

          child: Padding(

            padding: EdgeInsets.all(10.0),

            child: FlatButton(

              color: Colors.red,

              child: Text(

                "False",

                style: TextStyle(

                  fontSize: 20.0,

                  color: Colors.white,

                ),

              ),

              onPressed: () {

                setState(() {
                 checkAnswer(false);
                });

              },

            ),

          ),

        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: scoreKeeper,




    ),
        ),
    ]);

  }

}
