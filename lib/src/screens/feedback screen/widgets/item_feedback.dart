import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:untitled/src/models/feedback.dart' as f;
import 'package:untitled/src/screens/feedback%20screen/widgets/box_message.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ItemFeedback extends StatelessWidget {
  final f.Feedback feedback;

  const ItemFeedback({
    Key? key,
    required this.feedback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Color color;
    switch (feedback.status) {
      case 'Chưa phản hồi':
        color = const Color(0xFFF57D00);
        break;
      default:
        color = const Color(0xFF5C92FE);
        break;
    }

    List<String> choices = <String>[
      'Chỉnh sửa',
      'Xoá',
    ];
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // type and time and more button
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // type
                RichText(
                  text: TextSpan(
                    text: 'Loại: ',
                    style: AppTextStyle.lato.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: feedback.type,
                        style: AppTextStyle.lato.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // time
                Text(
                  feedback.time,
                  style: AppTextStyle.lato.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                // more button
                PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                  onSelected: (a) {},
                  itemBuilder: (BuildContext context) {
                    return choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                )
              ],
            ),
          ),
          // divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              color: const Color(0xFF000000).withOpacity(0.2),
            ),
          ),
          // text title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Tiêu đề',
              style: AppTextStyle.lato.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // title and image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                // title
                BoxMessage(
                  width: 200,
                  height: 100,
                  child: Text(
                    feedback.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.lato.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // image
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      feedback.image!,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // text status & icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //icon
                feedback.status == 'Đã phản hồi'
                    ? Image.asset(
                        'assets/ic_checkmark.png',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/ic_warning.png',
                        fit: BoxFit.cover,
                      ),
                const SizedBox(width: 5),
                //text status
                Text(
                  feedback.status,
                  style: AppTextStyle.lato.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: feedback.status == 'Đã phản hồi'
                        ? const Color(0xFF5C92FE)
                        : const Color(0xFFF57D00),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // text response
          if (feedback.status == 'Đã phản hồi')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: BoxMessage(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // text ban quan li
                    Text(
                      'Ban quản lý',
                      style: AppTextStyle.lato.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // text response
                    Text(
                      feedback.respond!,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.lato.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
