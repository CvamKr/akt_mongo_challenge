import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinkit extends StatelessWidget {
  final spinkit = SpinKitPulse(
    color: Colors.green,
    size: 50.0,
    // controller: AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 1200),
    // ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(child: spinkit),
    );
  }
}
