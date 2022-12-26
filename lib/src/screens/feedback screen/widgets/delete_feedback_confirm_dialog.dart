import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/feedback.dart' as fb;
import 'package:untitled/src/providers/feedback_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/helper/show_snack_bar.dart';

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
    return AlertDialog(
      backgroundColor: const Color(0xFFFCF6F6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      titlePadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Bạn có chắc chắc muốn\nxóa ý kiến này không?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFE2C6B),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.023,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    fixedSize: const Size(120, 30),
                  ),
                  child: const Center(
                    child: Text(
                      "HUỶ",
                      style: TextStyle(
                        color: AppColors.Black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    print("id feedback: ${widget.feedback.id}");
                    feedbackProvider.deleteFeedback(
                      context,
                      widget.feedback.id!,
                    );
                    Navigator.of(context).pop();

                    showSnackBar(
                      context,
                      "Đã xoá ý kiến!",
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDB2F68),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    fixedSize: const Size(120, 30),
                  ),
                  child: const Center(
                    child: Text(
                      "CHẮC CHẮN",
                      style: TextStyle(color: AppColors.White, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
