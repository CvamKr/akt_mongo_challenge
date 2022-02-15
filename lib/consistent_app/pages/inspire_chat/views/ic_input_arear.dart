import 'package:flutter/material.dart';

class ICInputArea extends StatefulWidget {
  @override
  _ICInputAreaState createState() => _ICInputAreaState();
}

class _ICInputAreaState extends State<ICInputArea> {
  String dropdownValue = '5m';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            // top: 80.0,
            right: 20.0,
          ),
          child: Container(
            height: 50,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey[100],
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey.withOpacity(0.2),
              //       spreadRadius: 3.0,
              //       blurRadius: 5.0)
              // ],
            ),
            child: Row(
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      color: Colors.grey[100],
                      // width: MediaQuery.of(context).size.width * 0.55,
                      child: TextFormField(
                        // controller: addTaskCtrl.title,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Type here"),
                      ),
                    ),
                  ),
                ),
                Icon(Icons.open_in_full),
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.send_outlined),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
