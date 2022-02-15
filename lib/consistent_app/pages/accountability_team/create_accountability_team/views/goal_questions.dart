import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/create_goal_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class accountability extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return QuestionListBuilder();
//   }
// }

// class QuestionListBuilder extends StatelessWidget {
//   List<Map> ques = [
//     {
//       "question": "What do you want to accomplish (in near future)?",
//       "tex1": "t1",
//       "example": "e1"
//     },
//     {
//       "question":
//           "Write minimum 2 actions you need to take  each day to accomplish your above set goal?",
//       "tex1": "t1",
//       "example": "e1"
//     },
//     {
//       "question": "Why do you want to accomplish your goal",
//       "tex1": "t1",
//       "example": "e1"
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.vertical,
//       itemCount: 1,
//       itemBuilder: (context, index) {
//         return GoalQuestion(
//           question: ques[index]['question'],
//           text1: ques[index]['tex1'],
//           example: ques[index]['example'],
//         );
//       },
//     );
//   }
// }

class GoalQuestion extends StatefulWidget {
  String question, text1, example;
  int index;
  // TextEditingController tfController;
  GoalQuestion({this.question, this.text1, this.example, this.index});
  @override
  _GoalQuestionState createState() => _GoalQuestionState();
}

class _GoalQuestionState extends State<GoalQuestion> {
  final createGoalCtrl = Get.put<CreateGoalCtrl>(CreateGoalCtrl());
  var controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (widget?.index == 0) {
    //   controller = createGoalCtrl?.goaltfCtrl;
    // } else if (widget.index == 1) {
    //   controller = createGoalCtrl?.goaltfCtrl;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildGreybox(),
        buildQuestion(),
        buildGreyContainer(),
        if (widget.index == 2) ...{
          postGoalBtn(),
        },
      ],
    );
  }

  Widget buildGreybox() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 16),
      child: Container(
          // width: 60,
          // height: 30,
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 6.0),
            child: Text(
              "1/2",
              style: TextStyle(fontSize: 16.0),
            ),
          )),
    );
  }

  Widget buildQuestion() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
      child: Text(
        widget?.question ?? 'question',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildGreyContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: Container(
          // height: 150,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopText(),
              // buildSecondLine(),
              //  buildDivider(),
              if (widget.index == 0) ...{
                buildGoalTf()
              } else if (widget.index == 1) ...{
                buildActionPlanTf()
              } else if (widget.index == 2) ...{
                buildReasonTf()
              },
              buildExampleText(),
              // if (widget.index == 2) ...{
              //   postGoalBtn(),
              // },
            ],
          )),
    );
  }

  Widget postGoalBtn() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
          onPressed: () {
            createGoalCtrl.postGoalToMongoDb();
          },
          child: Text(
            "Post",
            style: TextStyle(color: Colors.blue),
          )),
    );
  }

  buildGoalTf() {
    // print('index: ${widget.index}');
    return TextField(controller: createGoalCtrl.goaltfCtrl);
  }

  buildActionPlanTf() {
    // print('index: ${widget.index}');
    return TextField(controller: createGoalCtrl.actionPlantfCtrl);
  }

  buildReasonTf() {
    // print('index: ${widget.index}');
    return TextField(controller: createGoalCtrl.reasonTfCtrl);
  }

  Widget buildTopText() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Text(
        widget?.text1 ?? 'df',
        style: TextStyle(color: Colors.grey[800]),
      ),
    );
  }

  // Widget buildSecondLine() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8.0),
  //     child: Text(
  //       widget?.example ?? 'expmple',
  //       style: TextStyle(color: Colors.black),
  //     ),
  //   );
  // }

  // Widget buildDivider() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //     child: Divider(
  //       color: Colors.black,
  //     ),
  //   );
  // }

  Widget buildExampleText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.example,
        style: TextStyle(color: Colors.grey[700]),
      ),
    );
  }
}
