import 'package:flutter/material.dart';


class ICMessageTemplateList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: ListView.builder(
  itemCount:10,
  itemBuilder: (context, index) {
      return ICMessageTemplateList();
  },
),
    );
  }
}