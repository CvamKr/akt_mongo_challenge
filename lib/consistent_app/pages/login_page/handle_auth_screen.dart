import 'package:akt_mongo/consistent_app/pages/login_page/views/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'controller/auth_page_ctrl.dart';

class HandleAuthScreen extends StatefulWidget {
  @override
  _HandleAuthScreenState createState() => _HandleAuthScreenState();
}

class _HandleAuthScreenState extends State<HandleAuthScreen> {
  Widget relevantScreen = Scaffold(body: LoadingWidget());

  final loginPageCtrl = Get.put<AuthPageCtrl>(AuthPageCtrl());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: relevantScreen);
  }
}
