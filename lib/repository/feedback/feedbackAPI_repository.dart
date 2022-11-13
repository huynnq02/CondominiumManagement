import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';
import 'package:untitled/src/models/feedback.dart';

class FeedbackAPIRepository extends BaseRepository {
  Future<Response> createFeedbackAPIRepository(Feedback feedback) async {
    try {
      // print(feedback.toJson());
      var client = init();
      print("zo ne");
      print(feedback.toJson());
      final feedbackResponse = await client.post(
        '/api/UserFeedback',
        data: {
          "id": 0,
          "email": feedback.email,
          "type": feedback.type,
          "time": feedback.time,
          "title": feedback.title,
          "status": feedback.status,
          "content": feedback.content,
          "respond": feedback.respond,
          "image": feedback.image,
        },
      );
      print("ez qua");
      return feedbackResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> getUserFeedbackAPIRepository() async {
    try {
      // print(feedback.toJson());
      var client = init();
      print("zo ne");
      final feedbackResponse = await client.get(
        '/api/UserFeedback',
      );
      print("ez qua");
      return feedbackResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}
