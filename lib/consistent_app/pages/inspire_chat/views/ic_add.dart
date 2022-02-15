

import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/add_inspire_chat/ic_tags_for_posting.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/add_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ICAdd extends StatefulWidget {
  @override
  _ICAddState createState() => _ICAddState();
}

class _ICAddState extends State<ICAdd> {
  // final addInspireChatCtrl = Get.put<AddInspireChatCtrl>(AddInspireChatCtrl());
  final addInspireChatCtrl = Get.find<AddInspireChatCtrl>();

  final displayInspireChat = Get.find<DisplayInspireChatCtrl>();
  final loginPageCtrl = Get.find<AuthPageCtrl>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddInspireChatCtrl>(
        id: addInspireChatUiId,
        builder: (addInspireChatCtrl) {
          return addInspireChatCtrl.isUploading
              ? Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Scaffold(
                  appBar: buildAppBar(),
                  body: buildListView(),
                );
        });
  }

  Widget buildListView() {
    return ListView(
      children: [
        buildTextField(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IcTagsForPosting(
            isInAddIcPage: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<AuthPageCtrl>(builder: (_) {
                return GestureDetector(
                  onTap: () => EditDisName(),
                  child: Row(
                    children: [
                      Text("posting as "),
                      Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Text(
                          "${loginPageCtrl.currentUser.displayName}",
                          style:
                              TextStyle(color: Colors.blue[600], fontSize: 17),
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        size: 17,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        )
      ],
    );
  }

  Widget buildAppBar() {
    return AppBar(
      elevation: 0.0,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      title: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          "",
          style: TextStyle(color: Colors.black),
        ),
      ),
      actions: [
        GestureDetector(
            onTap: () async {
              bool ok = addInspireChatCtrl?.validate();
              if (ok) {
                await addInspireChatCtrl?.postChatToMongoDb();
                Get.back();

                // displayInspireChat?.getInspireChatFromDB();
                displayInspireChat?.getICbyTagsFromDB();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 16.0),
              child: Text("post",
                  style: TextStyle(color: Colors.blue, fontSize: 18)),
            ))
      ],
      backgroundColor: Colors.white,
    );
  }

  Future<void> EditDisName() {
    loginPageCtrl?.displayNameController?.text =
        loginPageCtrl.currentUser.displayName;
    return showModalBottomSheet(
        context: Get.context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.grey[100],
                              child: TextFormField(
                                controller:
                                    loginPageCtrl?.displayNameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "what people call you?"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      IconButton(
                          onPressed: () {
                            if (loginPageCtrl
                                    .displayNameController.text.length >
                                0) {
                              loginPageCtrl.updateUserName({
                                "displayName":
                                    loginPageCtrl?.displayNameController?.text
                              }, "users", loginPageCtrl.currentUser.id,
                                  fromInspireChat: true);

                              Get.back();
                            } else {
                              Get.back();
                              Get.snackbar(
                                "Hey!",
                                "We are pretty sure you do have a name :)",
                                duration: Duration(seconds: 2),
                                snackStyle: SnackStyle.FLOATING,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          icon: Icon(Icons.send_outlined)),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget buildTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 8.0),
      child: Container(
        color: Colors.grey[100],
        child: TextField(
          autofocus: true,
          controller: addInspireChatCtrl.userMessageCtrl,
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText:
                  "Write here. Who knows your words might even inspire someone!",
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
