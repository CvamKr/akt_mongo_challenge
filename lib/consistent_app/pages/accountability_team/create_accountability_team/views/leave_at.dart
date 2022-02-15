import 'package:flutter/material.dart';

class LeaveAt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Text("Are u sure u don't want an accountability team")),
          TextButton(
            child: Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
