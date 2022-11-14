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
    notifyListeners();
  }

  void showSuccessfulDialog(BuildContext context, String message) => showDialog(
        context: context,
        builder: ((context) => (SuccessfulFeedbackDialog(
              message: message,
            ))),
      );
  Future createUserFeedback(BuildContext context, fb.Feedback feedback) async {
    setIsLoading(true);
    var success =
        await FeedbackAPIProvider().createFeedbackAPIProvider(feedback);
    if (success == true) {
      showSuccessfulDialog(context, "Đã gửi ý kiến!");
      setIsLoading(false);
    } else if (success == false) {
      print("fail");
      showSuccessfulDialog(context, "Vui lòng thử lại sau!");
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
      showSuccessfulDialog(context, "Đã sửa ý kiến!");
      setIsLoading(false);
    } else if (success == false) {
      print("fail");
      showSuccessfulDialog(context, "Vui lòng thử lại sau!");
      setIsLoading(false);
    }
    notifyListeners();
  }
}
