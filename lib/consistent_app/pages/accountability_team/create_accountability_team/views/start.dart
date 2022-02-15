import 'package:flutter/material.dart';

class StartButton extends StatefulWidget {
  @override
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  double width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
              ),
              buildHead(),
              buildHead2(),
              buildMarkAccomplished()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHead() {
    return Text(
      "Everyday code on consistent app",
      style: TextStyle(color: Colors.black, fontSize: 18),
    );
  }

  Widget buildHead2() {
    return Text(
      "In Progress for 2:45min",
      style: TextStyle(color: Colors.green, fontSize: 16),
    );
  }

  Widget buildMarkAccomplished() {
    return Container(
              height: height*0.05,
              width: width*0.7,
              margin: EdgeInsets.all(20),
              child: TextButton(
                child: Text('Mark as accomplished', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),),
               
                onPressed: () {},
              ),
              decoration: BoxDecoration(
               color: Colors.green,
               borderRadius: BorderRadius.circular(20.0)
                ),
            );
  }
}
