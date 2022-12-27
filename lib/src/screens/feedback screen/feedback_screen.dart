import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/feedback.dart' as f;
import 'package:untitled/src/providers/feedback_provider.dart';
import 'package:untitled/src/screens/create%20feedback/create_feedback_screen.dart';
import 'package:untitled/src/screens/feedback%20screen/widgets/tab_not_response.dart';
import 'package:untitled/src/screens/feedback%20screen/widgets/tab_response.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedbacks =
        Provider.of<FeedbackProvider>(context, listen: true).feedbacks;
    final size = MediaQuery.of(context).size;
    late Color color = const Color(0xFFFCF6F6);
    List<f.Feedback> feedbacksNotResponse = [];
    List<f.Feedback> feedbacksResponse = [];

    for (var feedback in feedbacks) {
      print('feedback id: ${feedback.id}');
      if (feedback.status == 'Chưa phản hồi') {
        feedbacksNotResponse.add(feedback);
      } else {
        feedbacksResponse.add(feedback);
      }
    }

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDB2F68),
        title: const Text(
          'Ý kiến của bạn',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xFFEDEDED),
                ),
                child: TabBar(
                  controller: tabController,
                  labelStyle: AppTextStyle.lato.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xFFDB2F68),
                  ),
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF909090),
                  tabs: const [
                    Tab(text: 'Chưa phản hồi'),
                    Tab(text: 'Đã phản hồi'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    TabNotResponse(
                      feedbacks: feedbacksNotResponse,
                    ),
                    TabResponse(
                      feedbacks: feedbacksResponse,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDB2F68),
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateFeedbackScreen(),
            ),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.add),
            const SizedBox(width: 5),
            Text(
              'Gửi ý kiến',
              style: AppTextStyle.lato.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
