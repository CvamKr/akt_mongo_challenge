
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/add_inspire_chat_ctrl.dart';
import 'package:get/get.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<AddInspireChatCtrl>(() => AddInspireChatCtrl(), fenix: true);

  }
}
