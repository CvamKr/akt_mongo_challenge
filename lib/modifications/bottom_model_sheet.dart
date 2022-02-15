import 'package:akt_mongo/consistent_app/model/goal_model.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/hurray.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/views/ic_post_inspire.dart';
import 'package:flutter/material.dart';

showPostToInspire(value, context, GoalModel goal) {
  if (value) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HurrayMessage(goal),
              PostInspire(goal: goal),
            ],
          ),
        );
      },
    );
  }
}
