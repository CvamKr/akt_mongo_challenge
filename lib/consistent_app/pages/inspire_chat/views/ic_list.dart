import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/views/ic_message_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class ICList extends StatelessWidget {
  final DisplayInspireChatCtrl displayInspireChatCtrl =
      Get.put(DisplayInspireChatCtrl());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisplayInspireChatCtrl>(
      builder: (_) => displayInspireChatCtrl.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : displayInspireChatCtrl.displayInspireChatList.length == 0
              ? Container(height: 100, child: Center(child: Text("No posts")))
              : Container(
                  // color: Colors.yellow,
                  child: ListView.builder(
                    shrinkWrap: true,
                    // reverse: true,
                    controller: displayInspireChatCtrl?.scrollController,

                    // physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        displayInspireChatCtrl.displayInspireChatList.length +
                            1,
                    itemBuilder: (context, index) {
                      // print('index: $index');
                      //...
                      // print(
                      //     'length : ${displayInspireChatCtrl.displayInspireChatList.length}');
                      // print('index: $index');
                      // ...

                      // if (index == 0) {
                      //   print("a");
                      //   return Padding(
                      //     padding: const EdgeInsets.only(bottom: 8.0),
                      //     child: ICBelowAppBarMsg(),
                      //   );
                      // } else
                      if (index ==
                          displayInspireChatCtrl.displayInspireChatList.length +
                              0) {
                        return Column(
                          children: [
                            Container(
                                height: 150,
                                color: Colors.white,
                                // decoration: BoxDecoration(
                                //   color: Colors.grey[200],
                                //   gradient: LinearGradient(
                                //     begin: Alignment.centerLeft,
                                //     end: Alignment.centerRight,
                                //     colors: [
                                //       Colors.purple[200],
                                //       Colors.blue[200]
                                //     ],
                                //   ),
                                // ),
                                child: Center(child: Text(''))),
                          ],
                        );
                      } else {
                        // print("b");
                        // InspireChatModel ic =
                        //     displayInspireChatCtrl.displayInspireChatList[0];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: ICMessageTemplate(
                                  inspireChat: displayInspireChatCtrl
                                      .displayInspireChatList[index]

                                  // ic,
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 32),
                              child: Container(
                                color: Colors.grey[200],
                                height: 1,
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
                ),
    );
  }
}

// class ICList extends StatefulWidget {
//   @override
//   _ICListState createState() => _ICListState();
// }

// class _ICListState extends State<ICList> {
//   @override
//   Widget build(BuildContext context) {
//     return
//       ListView.builder(
//         shrinkWrap: true,
//         itemCount: 100,
//           itemBuilder: (BuildContext context, int index){
//         return InspireChatTemplate(inspireChat:,);
//         });

//   }
