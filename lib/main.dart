import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;


import 'package:google_fonts/google_fonts.dart';

import 'consistent_app/central_services/controller_binding.dart';
import 'consistent_app/pages/login_page/auth.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    //statusBarColor: Colors.pink, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      initialBinding: ControllerBinding(),
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Akt',
      home: Auth(),
      debugShowCheckedModeBanner: false,
    );
  }
}
