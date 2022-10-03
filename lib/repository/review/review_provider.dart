import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/review/review_repository.dart';

import '../../src/models/review.dart';

class ReviewPro extends BaseProvider<ReviewRepository> {
  @override
  ReviewRepository initRepository() {
    return ReviewRepository();
  }

  Future<List<Review>> get(List listLabel, String idProduct) async {
    final res = await repository.review(listLabel, idProduct);
    return (res.data['result'] as List).map((e) => Review.fromMap(e)).toList();
  }
}
