import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';

class DescribeFormProvider extends ChangeNotifier {
  // chuyển html sang chuỗi
  void test(String input) {
    var document = parse(input);
    print(document.outerHtml);
  }
}
