
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../my_persistent_navbar.dart';
import 'display_name.dart';
import 'loading_widget.dart';

class BuildAuthScreen extends StatelessWidget {
  final loginPageCtrl = Get.find<AuthPageCtrl>();
  Widget relevantScreen = Scaffold(body: LoadingWidget());

  @override
  Widget build(BuildContext context) {
    print("inside auth page");
    loginPageCtrl.checkDisplayName();
    return Scaffold(
        // backgroundColor: Colors.black,
        key: loginPageCtrl.scaffoldKey,
        body: GetBuilder<AuthPageCtrl>(
          builder: (_) {
            //         Future.delayed(Duration(seconds: 3)).then((_) {
            if (loginPageCtrl.displayNamePresent == null) {
              return relevantScreen;
            }
            relevantScreen = loginPageCtrl.displayNamePresent
                ?
                // DisplayQuickTasks()
                // HomePage()
                MyPersistentNavbar()
                : DisplayName();
            // });

            return relevantScreen;
          },
        ));
  }
}
