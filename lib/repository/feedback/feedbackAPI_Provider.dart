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
    print("ret data");
    print(res.data['success']);
    return res.data['success'];
  }
}
