// import 'package:flutter/material.dart';

// class InspireChatTemplate extends StatefulWidget {
//   @override
//   _InspireChatTemplateState createState() => _InspireChatTemplateState();
// }

// class _InspireChatTemplateState extends State<InspireChatTemplate>
//      {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 20.0,
//         top: 80.0,
//         right: 20.0,
//       ),
//       child: Container(

//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           color: Colors.grey[400],
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 3.0,
//                 blurRadius: 5.0)
//           ],
//         ),
//         child: buildTextColumn(),
//       ),
//     );
//   }

//   Column buildTextColumn() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 10.0),
//           child: buildTagText(),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 10.0, top: 15),
//             child: buildBodyText(),
//           ),
//         ),
//         buildRowElement()
//       ],
//     );
//   }

//   Row buildRowElement() {
//     return Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 5),
//             child: buildUserName(),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0, left: 2, bottom: 5),
//             child: Container(

//               decoration: BoxDecoration(
//                 image: DecorationImage(image: AssetImage('asset/image/teamwork.jpg')),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 200.0, top: 10, bottom: 5),
//               child: buildTimeText(),
//             ),
//           ),
//         ],
//       );
//   }

//   Text buildTimeText() {
//     return Text(
//       'just now',
//       style: TextStyle(color: Colors.black, fontSize: 16),
//     );
//   }

//   Text buildUserName() {
//     return Text(
//       'Naina, 0',
//       style: TextStyle(color: Colors.black, fontSize: 16),
//     );
//   }

//   Text buildBodyText() {
//     return Text(
//       'Woke early today at 6 am!Feels so nicev,hmb nvcnmnvhcgjxfdhzgsdxgfcgvhbj',
//       style: TextStyle(color: Colors.black, fontSize: 18),
//     );
//   }

//   Widget buildTagText() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         "#proudAct",
//         style: TextStyle(
//           color: Colors.grey[800],
//           fontSize: 16,
//         ),
//       ),
//     );
//   }
// }
import 'package:akt_mongo/consistent_app/model/inspire_chat_model.dart';
import 'package:flutter/material.dart';

class InspireChatTemplate extends StatefulWidget {
  final InspireChatModel inspireChat;
  const InspireChatTemplate({Key key, this.inspireChat}) : super(key: key);
  @override
  _InspireChatTemplateState createState() => _InspireChatTemplateState();
}

class _InspireChatTemplateState extends State<InspireChatTemplate> {
  var c1 = Colors.grey[600];
  @override
  Widget build(BuildContext context) {
    // var c1 = Colors.grey[200];
    // var c2 = Colors.
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //       Text("#proudAct", style: TextStyle(color: Colors.grey[800],
                //         fontSize: 14,),),
                // Text("Wak", style: TextStyle(color: Colors.grey[800],
                //         fontSize: 14,),),
                // SizedBox(
                //   height: 8,
                // ),
                buildTagText(),
                SizedBox(
                  height: 8,
                ),
                buildMessageText(),
                buildRow(),
                // SizedBox(
                //   height: 8,
                // ),
              ],
            ),
          )),
    );
  }

  Widget buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            buildBuildUserName(),
            SizedBox(
              width: 8,
            ),
            buildBuildStreakImage(),
          ],
        ),
        buildMessageTime(),
      ],
    );

    // return buildMessageTime();
  }

  Widget buildMessageText() {
    return Text(
      widget.inspireChat.userMessage,
      style: TextStyle(
        color: Colors.grey[800],
        fontSize: 14,
      ),
    );
  }

  Widget buildTagText() {
    return Text("#${widget.inspireChat.tags[0]}",
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 14,
        ));
  }

  Widget buildMessageTime() {
    return Text(
      widget.inspireChat.postedOn.toString(),
      style: TextStyle(
        color: Colors.grey[800],
        fontSize: 14,
      ),
    );
  }

  Widget buildBuildUserName() {
    return Text(
      widget.inspireChat.userName,
      style: TextStyle(
        color: Colors.grey[800],
        fontSize: 14,
      ),
    );
  }

  Widget buildBuildStreakImage() {
    return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage('assets/images/teamwork.jpg')),
        ));
  }
}
