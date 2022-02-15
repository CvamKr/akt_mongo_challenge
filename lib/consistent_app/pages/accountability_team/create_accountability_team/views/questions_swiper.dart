import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/goal_questions.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

// ignore: must_be_immutable
class QuestionsSwiper extends StatefulWidget {
  @override
  _QuestionsSwiperState createState() => _QuestionsSwiperState();
}

class _QuestionsSwiperState extends State<QuestionsSwiper> {
  PageController _pageController = new PageController(initialPage: 0);
  var tfcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // for (int i = 0; i < 3; i++) {
    //   tfControllersList.add(tfcontroller);
    // }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  updatePercentage() {
    setState(() {
      print("index is ${_pageController.toString} ");
    });
  }

  List tfControllersList = <TextEditingController>[];

  double percentageIndicator = 0.33;
  @override
  Widget build(BuildContext context) {
    return swiperContainer();
  }

  swiperContainer() {
    List<Map> ques = [
      {
        "question": "What do you want to accomplish (in near future)?",
        "tex1": "Goal",
        "example":
            "E.g loose belly fat, start working on my business idea, score"
                "80% marks, improve focus by meditation etc."
      },
      {
        "question":
            "Write minimum 2 actions you need to take  each day to accomplish your above set goal?",
        "tex1": "Action Plan",
        "example": ""
      },
      {
        "question": "Why do you want to accomplish your goal? (Optional)",
        "tex1": "reason",
        "example": ""
      },
    ];
    return Scaffold(
      body: ListView(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 2.5, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      2.50, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              height: 400,
              child: PageView.builder(
                  onPageChanged: (int page) {
                    setState(() {
                      percentageIndicator = ((page + 1) * 0.33).toDouble();
                      if (percentageIndicator == 0.9) percentageIndicator = 1;
                    });
                  },
                  itemCount: ques?.length,
                  itemBuilder: (c, index) {
                    return GoalQuestion(
                      question: ques[index]['question'],
                      text1: ques[index]['tex1'],
                      example: ques[index]['example'],
                      index: index,
                    );
                  })

              //  PageView(
              //   pageSnapping: true,
              //   controller: _pageController,
              // onPageChanged: (int page) {
              //   setState(() {
              //     PercentageIndicator = ((page + 1) * 0.3).toDouble();
              //   });
              // },

              //   children: [
              //     Container(
              //       color: Colors.orange,
              //     ),
              //     Container(
              //       color: Colors.white,
              //     ),
              //     Container(
              //       color: Colors.green,
              //       child: Text(""),
              //     )
              //   ],
              // ),
              ),
          lpi()
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  LinearPercentIndicator lpi() {
    return LinearPercentIndicator(
      padding: EdgeInsets.symmetric(vertical: 12),
      alignment: MainAxisAlignment.center,
      animateFromLastPercent: true,
      width: 50.0,
      lineHeight: 14.0,
      percent: percentageIndicator,
      backgroundColor: Colors.blueGrey.shade100.withOpacity(0.8),
      progressColor: Colors.lightBlue,
    );
  }
}
