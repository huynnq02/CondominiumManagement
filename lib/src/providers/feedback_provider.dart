import 'package:flutter/material.dart';
import 'package:untitled/repository/feedback/feedbackAPI_Provider.dart';
import 'package:untitled/src/models/feedback.dart' as fb;
import 'package:untitled/src/screens/create%20feedback/widgets/feedback_create_successful_dialog.dart';

class FeedbackProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  final List<fb.Feedback> _feedbacks = [];
  List<fb.Feedback> get feedbacks => _feedbacks;
  void setFeedbacks(List<fb.Feedback> feedbacks) {
    _feedbacks.clear();
    _feedbacks.addAll(feedbacks);
    _feedbacks.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  void createFeedback(fb.Feedback feedback) {
    _feedbacks.add(feedback);
    _feedbacks.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  void editFeedback(fb.Feedback feedback) {
    _feedbacks.removeWhere((element) => element.id == feedback.id);
    _feedbacks.add(feedback);
    _feedbacks.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  void showSuccessfulDialog(BuildContext context, String message, int count) =>
      showDialog(
        context: context,
        builder: ((context) => (SuccessfulFeedbackDialog(
              message: message,
              count: count,
            ))),
      );
  Future createUserFeedback(BuildContext context, fb.Feedback feedback) async {
    setIsLoading(true);
    var success =
        await FeedbackAPIProvider().createFeedbackAPIProvider(feedback);
    if (success == true) {
      createFeedback(feedback);
      showSuccessfulDialog(context, "Đã gửi ý kiến!", 1);
      setIsLoading(false);
    } else if (success == false) {
      print("fail");
      showSuccessfulDialog(context, "Vui lòng thử lại sau!", 1);
      setIsLoading(false);
    }
    notifyListeners();
  }

  void getUserFeedback() async {
    var res = await FeedbackAPIProvider().getUserFeedbackAPIProvider();

    List<fb.Feedback> feedbacks = res['result']
        .map<fb.Feedback>((json) => fb.Feedback.fromMap(json))
        .toList();

    setFeedbacks(feedbacks);
  }

  Future updateFeedback(BuildContext context, fb.Feedback feedback) async {
    setIsLoading(true);
    var success =
        await FeedbackAPIProvider().updateFeedbackAPIProvider(feedback);
    if (success == true) {
      editFeedback(feedback);
      showSuccessfulDialog(context, "Đã sửa ý kiến!", 2);
      setIsLoading(false);
    } else if (success == false) {
      print("fail");
      showSuccessfulDialog(context, "Vui lòng thử lại sau!", 2);
      setIsLoading(false);
    }
    notifyListeners();
  }
}
