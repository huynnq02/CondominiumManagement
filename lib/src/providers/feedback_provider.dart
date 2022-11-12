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

  void showSuccessfulDialog(BuildContext context, String message) => showDialog(
        context: context,
        builder: ((context) => (SuccessfulFeedbackDialog(
              message: message,
            ))),
      );
  Future createUserFeedback(BuildContext context, fb.Feedback feedback) async {
    var success =
        await FeedbackAPIProvider().createFeedbackAPIProvider(feedback);
    setIsLoading(true);
    if (success == true) {
      print("success");
      showSuccessfulDialog(context, "Đã gửi ý kiến!");
      setIsLoading(false);
    } else if (success == false) {
      print("fail");
      showSuccessfulDialog(context, "Vui lòng thử lại sau!");
      setIsLoading(false);
    }
    notifyListeners();
  }
}
