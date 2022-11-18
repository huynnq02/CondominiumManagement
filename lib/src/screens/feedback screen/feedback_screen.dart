import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/feedback.dart' as f;
import 'package:untitled/src/providers/feedback_provider.dart';
import 'package:untitled/src/screens/create%20feedback/create_feedback_screen.dart';
import 'package:untitled/src/screens/feedback%20screen/widgets/custom_button.dart';
import 'package:untitled/src/screens/feedback%20screen/widgets/item_feedback.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final feedbacks =
        Provider.of<FeedbackProvider>(context, listen: true).feedbacks;
    final size = MediaQuery.of(context).size;
    late Color color = const Color(0xFF5C92FE).withOpacity(0.3);

    for (var feedback in feedbacks) {
      if (feedback.status == 'Chưa phản hồi') {
        color = const Color(0xFFF57D00).withOpacity(0.3);
      }
    }
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ic chat left
            Positioned(
              left: 0,
              top: size.height * 0.1,
              child: Image.asset('assets/chat_left.png'),
            ),
            // ic chat right
            Positioned(
              right: 10,
              top: 10,
              child: Image.asset('assets/chat_right.png'),
            ),
            Column(
              children: [
                // text y kien cua ban
                Stack(
                  children: [
                    Text(
                      "Ý kiến của bạn",
                      style: AppTextStyle.tomorrow.copyWith(
                        fontSize: 30,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = AppColors.Black,
                      ),
                    ),
                    Text(
                      "Ý kiến của bạn",
                      style: AppTextStyle.tomorrow.copyWith(
                        fontSize: 30,
                        color: AppColors.White,
                        shadows: const [
                          Shadow(
                            blurRadius: 10.0,
                            color: AppColors.Black,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // text gui y kien
                Text(
                  'Gửi ý kiến của bạn đến ban quản lí',
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                // divider
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                  child: Divider(
                    color: const Color(0xFF000000).withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 10),
                // text ban co y kien hay than phien ?
                Text(
                  'Bạn có thắc mắc, ý kiến, than phiền ?',
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 13),
                // button tao y kien
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateFeedbackScreen(),
                      ),
                    );
                  },
                  child: const CustomButton(text: 'Tạo ý kiến'),
                ),
                const SizedBox(height: 20),
                //box
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: ListView.builder(
                      itemCount: feedbacks.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // text num of feedback
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              bottom: 10,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'Có ',
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '${context.watch<FeedbackProvider>().feedbacks.length}',
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0029FF),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ý kiến của bạn',
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //  Text(
                            //   'Có ${feedbacks.length} ý kiến của bạn',
                            //   style: AppTextStyle.lato.copyWith(
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.w700,
                            //   ),
                            // ),
                          );
                        }

                        f.Feedback feedback = feedbacks[index - 1];

                        return ItemFeedback(
                          feedback: feedback,
                        );
                      },
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