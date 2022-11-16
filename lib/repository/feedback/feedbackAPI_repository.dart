import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';
import 'package:untitled/src/models/feedback.dart';

class FeedbackAPIRepository extends BaseRepository {
  Future<Response> createFeedbackAPIRepository(Feedback feedback) async {
    try {
      var client = init();
      final feedbackResponse = await client.post(
        '/api/UserFeedback/AddFeedBack',
        data: {
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
      return feedbackResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> getUserFeedbackAPIRepository() async {
    try {
      var client = init();
      final feedbackResponse = await client.get(
        '/api/UserFeedback/GetCurrentUserFeedback',
      );
      return feedbackResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> updateFeedbackAPIRepository(Feedback feedback) async {
    try {
      var client = init();
      final feedbackResponse = await client.put(
        '/api/UserFeedback/UpdateFeedback',
        data: {
          "id": feedback.id,
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
      return feedbackResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> deleteFeedbackAPIRepository(int id) async {
    try {
      var client = init();
      final feedbackResponse = await client.delete(
        '/api/UserFeedback/DeleteFeedback',
        queryParameters: {
          "id": id,
        },
      );
      return feedbackResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}
