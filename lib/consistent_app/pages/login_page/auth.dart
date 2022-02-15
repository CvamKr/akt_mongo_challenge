import 'package:akt_mongo/consistent_app/pages/login_page/views/loading_widget.dart';
import 'package:akt_mongo/consistent_app/pages/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'controller/auth_page_ctrl.dart';
import 'views/auth_screen.dart';
import 'views/unauth_screen.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final loginPageCtrl = Get.put<AuthPageCtrl>(AuthPageCtrl());
  final userdata = GetStorage();
  Widget relevantScreen = Scaffold(body: LoadingWidget());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginPageCtrl.checkInternet();
    // relevantScreen = LoadingWidget();
    userdata.writeIfNull("ShowMeButtonClicked", false);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthPageCtrl>(
      builder: (_) {
        //         Future.delayed(Duration(seconds: 3)).then((_) {
        if (loginPageCtrl.isAuth == null) {
          return relevantScreen;
        }
        relevantScreen = loginPageCtrl.internet == "connected"
            ? loginPageCtrl.isAuth
                ? BuildAuthScreen()
                : LoginPage()
            : NoInternet();
        // });

        return relevantScreen;
      },
    );
  }
}
