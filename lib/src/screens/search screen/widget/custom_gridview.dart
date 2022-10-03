import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/src/screens/search%20screen/widget/suggested_phone.dart';

import '../../../providers/repository_provider.dart';

class CustomGridView extends StatelessWidget {
  CustomGridView({
    Key? key,
  }) : super(key: key);
  List<Phone> listPhone = [];

  void rangePoint() {
    Phone tg;
    int n = listPhone.length;

    for (int i = 0; i < n - 1; i++) {
      for (int j = i + 1; j < n; j++) {
        if (double.parse(listPhone[i].statistical!.overallScore.toString()) <
            double.parse(listPhone[j].statistical!.overallScore.toString())) {
          // Hoan vi 2 so a[i] va a[j]
          tg = listPhone[i];
          listPhone[i] = listPhone[j];
          listPhone[j] = tg;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    late RepositoryProvider provider =
        Provider.of<RepositoryProvider>(context, listen: false);
    listPhone = provider.phones;
    return GridView.builder(
      itemCount: 4,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.52,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        rangePoint();
        return SuggestedPhone(phone: listPhone[index]);
      },
    );
  }
}
