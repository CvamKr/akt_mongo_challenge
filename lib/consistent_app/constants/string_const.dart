import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final authPageCtrl = Get.find<AuthPageCtrl>();

// final String baseUrl = authPageCtrl?.serverUrl;

// String baseUrl = "https://powerful-headland-89052.herokuapp.com";
String baseUrl = "https://akt-mongo-challenge.herokuapp.com";

//...
// "https://powerful-headland-89052.herokuapp.com";
// ...
const String accomplished = "accomplished";
const String inProgress = "inProgress";
const String committed = "committed";

//display goals
const String displayGoalsId = "displayGoalsId";
const String inspirePost = "inspirePost";
const String inspireChatDisplayName = "inspireChatDisplayName";

//accountabilityTeam
const String groupProgressId = "groupProgressId";
const String leaveAtPopup = "leaveAtPopup";
const String displayATId = "displayAT";
const String displayInspireChat = "displayInspireChat";
const String createAcTeamId = "createAcTeamId";

//userATstatus
const String smallGoals = "smallGoals";
const String groupGoals = "groupGoals";

const String want = "want";
const String dontWant = "dontWant";

var logger = Logger();

//add inspire chat
const String addInspireChatUiId = "addInspireChatUiId";

//display inspire chat
const String displayInspireChatUiId = "displayInspireChatUiId";
