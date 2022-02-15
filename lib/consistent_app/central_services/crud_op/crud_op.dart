import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:logger/logger.dart';

var logger = Logger();

class CrudOp extends GetxController {
  var dio = Dio();

  Future<bool> updateDoc({Map json, String colName, String docId}) async {
    logger.d("inside updateDoc");
    //...
    // print("docId $docId");
    // ...
    String apiUrl = "$baseUrl/crudOp/updateDoc/$docId/$colName/abc";
    //...
    // print("api Url is $apiUrl ");
    // print("present data for updating : $json");
    // ...
    //  Map data = {
    //    "\$set": map
    //  };
    try {
      Response response = await dio.put(apiUrl, data: json);
      print('response code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print("response is 200..Ok : ${response.data.toString()}");
        // ...
        logger.d('doc updated!');
        // resetQtInputArea();

        return true;
      }
      return false;
    } catch (e) {
      logger.e("error while updating: $e");

      return false;
    }
  }
}
