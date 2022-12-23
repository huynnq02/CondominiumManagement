import 'package:flutter/material.dart';
import 'package:untitled/repository/feedback/feedbackAPI_Provider.dart';
import 'package:untitled/src/models/feedback.dart' as fb;
import 'package:untitled/src/screens/create%20feedback/widgets/feedback_create_successful_dialog.dart';
import 'package:untitled/utils/helper/show_snack_bar.dart';

class FeedbackProvider extends ChangeNotifier {
  List<fb.Feedback> _feedbacks = [];
  List<fb.Feedback> get feedbacks => _feedbacks;

  void setFeedbacks(List<fb.Feedback> feedbacks) {
    _feedbacks = feedbacks;
    notifyListeners();
  }

  void setEmptyFeedback() {
    // _numsOfFeedbacks = 0;
    _feedbacks.clear();
    notifyListeners();
  }

  void createFeedback(BuildContext context, fb.Feedback feedback) async {
    int id = await FeedbackAPIProvider().createFeedbackAPIProvider(feedback);
    feedback.id = id;
    _feedbacks.add(feedback);

    notifyListeners();
  }

  void editFeedback(fb.Feedback feedback) async {
    await FeedbackAPIProvider().updateFeedbackAPIProvider(feedback);
    _feedbacks.removeWhere((element) => element.id == feedback.id);
    _feedbacks.add(feedback);
    notifyListeners();
  }

  void deleteFeedback(BuildContext context, int id) async {
    var success = await FeedbackAPIProvider().deleteFeedbackAPIProvider(id);
    if (success == true) {
      _feedbacks.removeWhere((element) => element.id == id);
    } else if (success == false) {}
    notifyListeners();
  }
}
