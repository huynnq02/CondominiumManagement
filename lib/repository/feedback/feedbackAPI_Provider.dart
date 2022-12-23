import 'dart:convert';

import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/feedback/feedbackAPI_repository.dart';
import 'package:untitled/src/models/feedback.dart';

class FeedbackAPIProvider extends BaseProvider<FeedbackAPIRepository> {
  @override
  FeedbackAPIRepository initRepository() {
    return FeedbackAPIRepository();
  }

  Future<int> createFeedbackAPIProvider(Feedback feedback) async {
    var res = await repository.createFeedbackAPIRepository(feedback);
    String resBody = res.toString();
    var jsonData = jsonDecode(resBody);
    return jsonData['result'];
  }

  Future<List<Feedback>> getUserFeedbackAPIProvider() async {
    var res = await repository.getUserFeedbackAPIRepository();
    String resBody = res.toString();
    var jsonData = jsonDecode(resBody);
    print(Map<String, dynamic>.from(jsonData['result'])['items']);
    return (Map<String, dynamic>.from(jsonData['result'])['items'] as List)
        .map((e) => Feedback.fromMap(e))
        .toList();
  }

  Future updateFeedbackAPIProvider(Feedback feedback) async {
    var res = await repository.updateFeedbackAPIRepository(feedback);
    return res.data['success'];
  }

  Future deleteFeedbackAPIProvider(int id) async {
    var res = await repository.deleteFeedbackAPIRepository(id);
    print(res.data['success']);
    return res.data['success'];
  }
}
