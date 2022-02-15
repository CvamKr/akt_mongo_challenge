import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/create_ac_team/create_ac_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HowItWorks extends StatelessWidget {
  final isExpanded;
  HowItWorks({@required this.isExpanded});
  List<String> list = [
    "You agree to form an accountability group.",
    "We look for all those other users who like you, also want to be consistent to their goals. ",
    "We then pick the 3 of you and form an accountability group.\n\nIt's an automatic process and subject to availability of users.  ",
    "Now each of you can see each other's goals and progress. Use this space to commit to your goals.",
    "Use the Akt.connect space to connect with your accountability group. Globally, interact with people who like you want to grow. ",
    "We hope we help you be atleast a bit more accountable and consistent than you were yesterday:)"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: Text("How it works?"),
        initiallyExpanded: isExpanded,
        children: [
          buildSwiper(),
          // buildText(
          //     "1. Once you agree to form an accountability group, we look for all those other users who like you, also want to be consistent to their goals. "),
          // buildText(
          //     "2. We then pick the 3 of you and form an accountability group. "),
          // buildText(
          //     " 3. Now each of you can see each other's goals and progress. Use this space to commit to your goals."),
          // buildText(
          //     "4. Use the Akt.connect space to connect with your accountability group. Globally, interact with people who like you want to grow. "),
          // buildText(
          //     "5. We hope we help you be a bit more accountable and consistent than you were yesterday. If we do, please rate us good :) Have some suggestions?, you are always welcome."),
          SizedBox(height: 16)
        ],
      ),
    );
  }

  buildText(String text, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Text("${index + 1}", style: TextStyle(fontSize: 32)),
            SizedBox(height: 8),
            Text(text ?? "", style: TextStyle(fontSize: 16)),
            index == 0 ? buildReasearchSays() : Container()
          ],
        ),
      ),
    );
  }

  Widget buildSwiper() {
    return Container(
      height: 250,
      child: Swiper(
        loop: false,
        autoplay: false,
        pagination: new SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: new DotSwiperPaginationBuilder(
              activeColor: Colors.black,
              activeSize: 4,
              size: 4,
              space: 3,
              color: Colors.grey),
        ),
        // viewportFraction: .7,
        // containerHeight: 400,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return buildText(list[index], index);
        },
      ),
    );
  }
}
