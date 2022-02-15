import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class DisplayName extends StatelessWidget {
  TextEditingController displayNameCtrl = TextEditingController();
  final loginPageCtrl = Get.find<AuthPageCtrl>();
  SnackBar snackBar = SnackBar(
    content: Text("We are sure you do have a name :)"),
    duration: Duration(seconds: 2),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0XFfeef2f3),
            Color(0xff8e9eab),

            // Colors.red
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        bottom: 120,
                        top: 0,
                        left: -20,
                        right: MediaQuery.of(context).size.width * 0.33,
                        child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Image.asset(
                              "assets/images/hello.png",
                              fit: BoxFit.contain,
                            )),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.35),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                              child: Text(
                                "   ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.blueGrey.shade800),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                              child: Text(
                                "What should we call you?",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey),
                              ),
                            ),
                          ])
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.4),
                            spreadRadius: 4,
                            blurRadius: 8,
                            offset:
                                Offset(0, 2.5), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12)),
                    width: double.infinity,
                    child: TextField(
                      controller: loginPageCtrl.displayNameController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your name",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        hintStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      // onChanged: (String value) {
                      //   if (value.length < 3) {

                      //   } else {
                      //     loginPageCtrl.currentUser.username = value;
                      //   }
                      // },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(4),
                          primary: Color(0xff006266),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: 
                        
                        
                        loginPageCtrl.isUpdating
                            ? null
                            : () {
                                if (loginPageCtrl
                                        ?.displayNameController?.text?.length >
                                    0) {
                                  loginPageCtrl.isUpdating = true;
                                  loginPageCtrl.updateUserName({
                                    "displayName": loginPageCtrl
                                        ?.displayNameController?.text
                                  }, "users", loginPageCtrl.currentUser.id,
                                      fromInspireChat: false);
                                  loginPageCtrl.isUpdating = false;
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                              ,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
