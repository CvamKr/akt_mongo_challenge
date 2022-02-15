import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DontWantAcTeamReason extends StatelessWidget {
  final authPageCtrl = Get.find<AuthPageCtrl>();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(
        children: [
          emoji(),
          text(),
        ],
      ),
      SizedBox(height: 10,),
      buildQuestionText(),
      tellUsReason()
    ]));
  }

emoji() {
    return Container(
      height: 50,
      width: 50,
      child: Image.network(
          "https://thumbs.dreamstime.com/b/art-illustration-205691653.jpg"),
    );
  }

  text() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Why ${authPageCtrl.currentUser.displayName}, Why?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
    );

  }

  Widget buildQuestionText(){
     return Text("Please tell us your reason so that we can work on that.", style: TextStyle(fontSize: 16));
  }
  tellUsReason(){
  return Row(
    children: [
      Expanded(
        child: TextField(
          autofocus: true,
        decoration: InputDecoration(
            border: new UnderlineInputBorder(
              borderSide: new BorderSide(
                color: Colors.red
              )
            ),
          hintText: ''
        ),
),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: (){},
          icon: Icon(Icons.send),
        ),
      )
    ],
  );
  }
  
}
