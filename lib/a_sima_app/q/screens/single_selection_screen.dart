import 'package:flutter/material.dart';
import 'package:flutter_question_answer_widget/flutter_question_answer_widget.dart';

class SingleSelectionScreen extends StatefulWidget {
  SingleSelectionScreen({required Key key}) : super(key: key);

  @override
  _SingleSelectionScreenState createState() => _SingleSelectionScreenState();
}

class _SingleSelectionScreenState extends State<SingleSelectionScreen> {

  String q1 = "";
  String q2 = "";
  String q3 = "";
  String q4 = "";
  String q5 = "";
  String q6 = "";
  String q7 = "";

late String _value1;
late String _value2;
late String _value3;
late String _value4;
late String _value5;
late String _value6;

  List heroList1 = ["", "", "" , "", "", ""];
  List selectedHeroList1 = [];

  List heroList2 = ["", "", "" , "", "", ""];
  List selectedHeroList2 = [];

  List heroList3 = ["", "", "" , "", "", ""];
  List selectedHeroList3 = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    return Scaffold(
      appBar: AppBar(
        title: Text("سوالات"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FlutterQuestionAnswerWidget.singleSelection(
                answered: _value1,
                question: q1,
                answerList: ["Yes", "No"],
                answerWidth: size.width,

                onChanged: (String value) {
                  setState(() {
                    print(value);
                    _value1 = value;
                  });
                },
              ),
              FlutterQuestionAnswerWidget.singleSelection(
                answered: _value1,
                question: q2,
                answerList: ["1", "2", "3" , "4" , "5" , "6" , "7" , "8" , "9" , "10" ],
                answerWidth: size.width,
                onChanged: (String value) {
                  setState(() {
                    print(value);
                    _value1 = value;
                  });
                },
              ),
              FlutterQuestionAnswerWidget.multiSelectionView(
                answeredList: selectedHeroList1,
                question: q3,
                answerList: heroList1,
                answerWidth: size.width,
                onChanged: (String value) {
                  if (selectedHeroList1.contains(value)) {
                    setState(() {
                      selectedHeroList1.remove(value);
                    });
                  } else {
                    setState(() {
                      print(value);
                      selectedHeroList1.add(value);
                    });
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
