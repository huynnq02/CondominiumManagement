import 'package:flutter/widgets.dart';
import 'package:untitled/src/models/review.dart';

class PaginatorProvider extends ChangeNotifier {
  int state = 1;
  void onchange(int state) {
    this.state = state;

    notifyListeners();
  }

  
  var listReview = [];
  fetchReview(List<Review>? input) {
    listReview = [];
    var lst = input;

    int sizeList = 10;//sô lượng comment hiển thị trong 1 trang

    //sublist chia ra theo từng trang
    for (var i = 0; i < lst!.length; i += sizeList) {
      listReview.add(lst.sublist(
          i, i + sizeList > lst.length ? lst.length : i + sizeList));
    }
  
  }
}
