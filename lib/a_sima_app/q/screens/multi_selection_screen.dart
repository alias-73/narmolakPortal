import 'package:flutter/material.dart';
import 'package:flutter_question_answer_widget/flutter_question_answer_widget.dart';

class MultiSelectionScreen extends StatefulWidget {
  @override
  _MultiSelectionScreenState createState() => _MultiSelectionScreenState();
}

class _MultiSelectionScreenState extends State<MultiSelectionScreen> {
  List movieList = [
    "Man of steel",
    "Batman vs Superman",
    "Suicide Squad",
    "Justice League",
    "Wonder Woman"
  ];
  List selectedMovieList = [];

  List heroList = ["Batman", "Superman", "Wonder Women"];
  List selectedHeroList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi Selection"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            FlutterQuestionAnswerWidget.multiSelectionView(
              answeredList: selectedMovieList,
              question: "1. What is the last movie you watched?",
              answerList: movieList,
              answerWidth: 200,
              selectedAnswerBackGroundColor: Colors.green,
              unSelectedAnswerBackGroundColor: Colors.grey.shade200,
              onChanged: (String value) {
                if (selectedMovieList.contains(value)) {
                  setState(() {
                    selectedMovieList.remove(value);
                  });
                } else {
                  setState(() {
                    selectedMovieList.add(value);
                  });
                }
              },
            ),
            FlutterQuestionAnswerWidget.multiSelectionView(
              answeredList: selectedHeroList,
              question: "2. Who is your favorite superhero?",
              answerList: heroList,
              answerWidth: 200,
              onChanged: (String value) {
                if (selectedHeroList.contains(value)) {
                  setState(() {
                    selectedHeroList.remove(value);
                  });
                } else {
                  setState(() {
                    selectedHeroList.add(value);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
