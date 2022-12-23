import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:untitled/src/models/feedback.dart' as f;
import 'package:untitled/src/screens/feedback%20screen/widgets/delete_feedback_confirm_dialog.dart';
import 'package:untitled/src/screens/update%20feedback%20screen/update_feedback_screen.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class ItemFeedback extends StatefulWidget {
  final f.Feedback feedback;

  const ItemFeedback({
    Key? key,
    required this.feedback,
  }) : super(key: key);

  @override
  State<ItemFeedback> createState() => _ItemFeedbackState();
}

class _ItemFeedbackState extends State<ItemFeedback> {
  bool showMore = false;
  @override
  Widget build(BuildContext context) {
    late Color color;
    switch (widget.feedback.status) {
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

    print('url image: ${widget.feedback.image}');

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
                        text: widget.feedback.type,
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
                  widget.feedback.time.formatDateTime(),
                  style: AppTextStyle.lato.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                // more button
                if (widget.feedback.status == 'Chưa phản hồi')
                  PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.more_horiz_rounded,
                    ),
                    onSelected: (option) {
                      //navigate
                      if (option == 'Chỉnh sửa') {
                        print("Chỉnh sửa");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateFeedbackScreen(
                              feedback: widget.feedback,
                            ),
                          ),
                        );
                      } else if (option == 'Xoá') {
                        print("Xóa");
                        print("feedback.id: ${widget.feedback.id}");
                        showDeleteConfirmPopupDialog(context, widget.feedback);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return choices.map((String choice) {
                        print(choice);
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(choice),
                              choice.compareTo("Xoá") == 0
                                  ? const Icon(
                                      Icons.delete,
                                      size: 15,
                                    )
                                  : const Icon(
                                      Icons.edit,
                                      size: 15,
                                    ),
                            ],
                          ),
                        );
                      }).toList();
                    },
                  ),
                if (widget.feedback.status == 'Đã phản hồi')
                  const SizedBox(
                    width: 20,
                  )
              ],
            ),
          ),
          // divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              color: const Color(0xFF000000).withOpacity(0.4),
            ),
          ),
          // text title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.feedback.title,
              style: AppTextStyle.lato.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: const Color(0xFFDB2F68),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              widget.feedback.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.lato.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 15),
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                widget.feedback.image == null || widget.feedback.image!.isEmpty
                    ? null
                    : Align(
                        alignment: Alignment.center,
                        child: Image.network(
                          widget.feedback.image!,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
          ),
          const SizedBox(height: 10),

          // divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              color: const Color(0xFF000000).withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 5),
          // text status & icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //text status
                Text(
                  widget.feedback.status,
                  style: AppTextStyle.lato.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: widget.feedback.status == 'Đã phản hồi'
                        ? const Color(0xFF5C92FE)
                        : const Color(0xFFF57D00),
                  ),
                ),
                //icon
                InkWell(
                  onTap: () {
                    setState(() {
                      showMore = !showMore;
                    });
                  },
                  child: widget.feedback.status == 'Đã phản hồi'
                      ? showMore
                          ? Image.asset(
                              'assets/down.png',
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/up.png',
                              fit: BoxFit.cover,
                            )
                      : Image.asset(
                          'assets/clock.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          // text response
          if (widget.feedback.status == 'Đã phản hồi' && showMore)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.feedback.respond!,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.lato.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
            ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void showDeleteConfirmPopupDialog(
          BuildContext context, f.Feedback feedback) =>
      showDialog(
        context: context,
        builder: ((context) => DeleteFeedbackConfirmDialog(
              feedback: feedback,
            )),
      );
}
