import 'dart:convert';

import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/feedback/feedbackAPI_repository.dart';
import 'package:untitled/src/models/feedback.dart';

class FeedbackAPIProvider extends BaseProvider<FeedbackAPIRepository> {
  @override
  FeedbackAPIRepository initRepository() {
    return FeedbackAPIRepository();
  }

  Future createFeedbackAPIProvider(Feedback feedback) async {
    var res = await repository.createFeedbackAPIRepository(feedback);
    return res.data['success'];
  }

  Future getUserFeedbackAPIProvider() async {
    var res = await repository.getUserFeedbackAPIRepository();
    return res.data;
  }

  Future updateFeedbackAPIProvider(Feedback feedback) async {
    var res = await repository.updateFeedbackAPIRepository(feedback);
    print("kq ne bro");
    print(res.data['success']);
    return res.data['success'];
  }
}
