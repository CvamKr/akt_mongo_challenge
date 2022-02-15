import 'dart:convert';
import 'dart:io';

import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/user.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/views/ic_app_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../my_persistent_navbar.dart';

class AuthPageCtrl extends GetxController {
  bool displayNamePresent;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // final groupRef = Firestore.instance.collection('groups');
  // final groupChatRef = Firestore.instance.collection('groupChats');
  User currentUser = User();
  DateTime timestamp = DateTime.now();
  TextEditingController chatController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAuth;
  // String baseUrl = "https://powerful-headland-89052.herokuapp.com";
  Logger logger = Logger();
  Dio dio = new Dio();
  String serverUrl;
  String internet = "not connected";

  // final firebaseMessagingCtrl =
  //     Get.put<FirebaseMessagingCtrl>(FirebaseMessagingCtrl());
  // final displayATCtrl = Get.find<DisplayATCtrl>();
  //

  // Future<bool> getBaseUrl() async {
  //   bool success = false;
  //   logger.d("in getBaseUrl");
  //   await databaseReference
  //       .child("baseUrl")
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     baseUrl = snapshot?.value;
  //     // serverUrl = snapshot?.value;
  //     logger.d('baseUrl : $baseUrl');
  //     success = true;
  //   }).onError((error, stackTrace) {
  //     logger.d("Error while getting baseUrl: $error");
  //     Get.snackbar("", "Error while getting baseUrl: $error",
  //         snackPosition: SnackPosition.BOTTOM);
  //     success = false;
  //   });
  //   return success;
  // }

  handleSignIn(GoogleSignInAccount account) async {
    logger.d("in handleSignIn");
    if (account != null) {
      logger.d('User Signed in!:$account');
      //firebaseMessagingCtrl.subscribeToEvents();
      print("in auth page ctrl if");
      // firebaseMessagingCtrl.configureCallbacks();
      print('FCM events subscribed');
      await
          // createUserInFirestore();
          checkUserInDb();
      isAuth = true;
      update();
    } else {
      logger.d('user signed out');
      isAuth = false;
      update();
    }
  }

  
  

  bool isUpdating = false;
  updateUserName(Map map, String colName, String docId,
      {@required bool fromInspireChat}) async {
    logger.d("inside update doc");
    //...
    // print(docId);
    //...
    String apiUrl = "$baseUrl/crudOp/updateDoc/$docId/$colName/abc";
    //...
    print("api Url is $apiUrl ");
    // print("present data for updating : $map");
    //...
    try {
      Response response = await dio.put(apiUrl, data: {"\$set": map});
      print('response code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print("response is 200..Ok : ${response.data.toString()}");
        //...
        logger.d('doc updated!');
        // resetQtInputArea();
        currentUser.displayName = displayNameController.text;
        if (fromInspireChat == true) {
          loginPageCtrl.update();
        }
        if (fromInspireChat == false) {
          currentUser.accountabilityTeamId = dontWant;
          Get.offAll(MyPersistentNavbar());
        }
        Get.snackbar(currentUser.displayName, "Name Updated!",
            snackPosition: SnackPosition.BOTTOM);

        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  // bool userDbExists;
  Map _userJson;
  checkUserInDb() async {
    logger.d('in checkUserInDb');
    final GoogleSignInAccount gUser = googleSignIn.currentUser;
    // if (!await getBaseUrl()) return;
    _userJson = await getUserDb(gUser);

    if (_userJson == null) {
      await createUserDb(gUser);
    } else {
      //deserialize user
      currentUser = User.fromJson(_userJson);
      //...
      // logger.d('currentUser details:'
      //     '\ncurrentUser id: ${currentUser.id}'
      //     '\ncurrentUser email: ${currentUser.email}');
      // ...
    }
    // else {
    //   deserializUser();
    // }
  }

  //  Widget authPageRedirection() {
  //   if (usernamePresent == null) {
  //     return LoadingWidget();
  //   } else if (usernamePresent == true) {
  //     return DisplayQuickTasks();
  //   } else {
  //     return UserName();
  //   }
  // }

  checkDisplayName() async {
    if (currentUser?.displayName == '' || currentUser?.displayName == null) {
      displayNamePresent = false;
    } else {
      displayNamePresent = true;
    }
  }

  updateUsernameToDb() async {
    logger.d("in updateUsernameToDb");
    //...
    // print("gUser id: ${currentUser?.id}");
    //...

    String apiUrl = "$baseUrl/user/updateUser";
    //...
    // print("apiUrl is :$apiUrl");
    //...

    currentUser?.username = displayNameController.text;
    // currentUser?.id = currentUser?.id;
    // ...
    // logger.d("cuurentUser username : ${currentUser?.username}");
    //...
    // logger.d("current user id : ${currentUser.id}");
    //...

    try {
      Response response = await dio.post(apiUrl, data: currentUser?.toJson());
      logger.d("createUserDb: response.statusCode: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        currentUser.displayName = displayNameController.text;
        update([displayATId]);
        logger.d("response is: ${response.data.toString()}");
        return response;
      }
    } catch (e) {
      print('error while updating username in db: ${e.message}');
    }
  }

  Future<Map> getUserDb(GoogleSignInAccount gUser) async {
    logger.d("inside getUserDb");
    var url = "$baseUrl/user/getUserById/${gUser.id}";
    logger.d("baseUrl: $baseUrl");

    try {
      var response = await http.get(Uri.parse(url));
      logger.d('response.statusCode : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.d('user db exists');
        print('response status : 200');
        //...
        // print('response.body: ${response.body}');
        //...

        var userJson = json.decode(response.body);
        // currentUser.username = userJson.username.toString();
        // logger.d("userJson: ${userJson}");
        return userJson;

        // userDbExists = true;
      } else {
        logger.d('response.statusCode : ${response.statusCode}');
        logger.d('user db dosen\'t exist');
        // print('currentUser: ${currentUser}');
        // userDbExists = false; //ie now have to create userDb
        return null;
      }
    } catch (e) {
      logger.e('error while gettingUserDb: $e');
      return null;
    }
  }

  createUserDb(gUser) async {
    logger.d("in createUserDb");
    //...
    // print("gUser id: ${gUser?.id}");
    //...

    String apiUrl = "$baseUrl/user/createUser";
    //...
    // print("apiUrl is :$apiUrl");
    //...

    //feeding data into current user.
    // User currentUser = User();
    currentUser?.id = gUser?.id;
    currentUser?.email = gUser?.email;
    //...
    // logger.d("currentUser json: ${currentUser?.toJson()}");
    // logger.d("currentUser id : ${currentUser?.id}");
    // logger.d("currentUser email : ${currentUser?.email}");
    // logger.d("currentUser at : ${currentUser?.accountabilityTeamId}");
    //...

    try {
      Response response = await dio.post(apiUrl, data: currentUser?.toJson());
      logger.d("createUserDb: response.statusCode: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // logger.d("response is: ${response.data.toString()}");
        // ...
        return response;
      }
    } catch (e) {
      logger.e('error while creating user db: ${e.message}');
    }
  }



  login() {
    googleSignIn.signIn();
  }

  logout([accountabilityTeamPresent]) async {
    // displayATCtrl.isShowMeBtnClickedd = false;
    currentUser = User();
    if (accountabilityTeamPresent != null) {}
    await googleSignIn.signOut();
    logger.d('Logged out');
  }

  listenAccount() async {
    logger.d('in listenAccount');
    // await getBaseUrl();
    googleSignIn.onCurrentUserChanged.listen((account) {
      logger.d("in onCurrentUserChanged");
      handleSignIn(account);
    }, onError: (err) {
      logger.e("Error signing in : $err");
      // Get.snackbar("", "Error signing in : $err")();
    }); //Reauthenticate when app is opened!!
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      logger.d('in signInSilently');
      // handleSignIn(account);
    }).catchError((err) {
      logger.d('Error signing in : $err');
      isAuth = false;
      update();
    });
  }

  // Future<bool> check() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   }
  //   return false;
  // }

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('you are connected to the internet');
        internet = "connected";
      }
    } on SocketException catch (_) {
      print('you are not connected');
      internet = "not connected";
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    checkInternet(); // check();
    // await getBaseUrl();
    listenAccount();
  }
}
