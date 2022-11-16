import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/feedback.dart' as fb;
import 'package:untitled/src/providers/feedback_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

class DeleteFeedbackConfirmDialog extends StatefulWidget {
  fb.Feedback feedback;
  DeleteFeedbackConfirmDialog({Key? key, required this.feedback})
      : super(key: key);

  @override
  State<DeleteFeedbackConfirmDialog> createState() =>
      _DeleteFeedbackConfirmDialogState();
}

class _DeleteFeedbackConfirmDialogState
    extends State<DeleteFeedbackConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        height: height * 0.18,
        width: width * 0.8,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/logout-confirm-dialog-background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17, left: 8, right: 8),
                child: feedbackProvider.isLoading == true
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          const Text(
                            "Bạn có muốn xóa ý kiến",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.023,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  print("id feedback: ${widget.feedback.id}");
                                  feedbackProvider.deleteFeedback(
                                    context,
                                    widget.feedback.id!,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.LogoutButtonColor,
                                  fixedSize: Size(
                                    width * 0.28,
                                    height * 0.035,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  ),
                                ),
                                child: const Text(
                                  "Đồng ý",
                                  style: TextStyle(
                                      color: AppColors.White, fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.08,
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.Black,
                                  fixedSize: Size(
                                    width * 0.28,
                                    height * 0.035,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  ),
                                ),
                                child: const Text(
                                  "Hủy",
                                  style: TextStyle(
                                      color: AppColors.White, fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
