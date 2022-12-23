import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/models/feedback.dart' as f;
import 'package:untitled/src/screens/feedback%20screen/widgets/item_feedback.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

class TabResponse extends StatefulWidget {
  final List<f.Feedback> feedbacks;

  const TabResponse({
    Key? key,
    required this.feedbacks,
  }) : super(key: key);

  @override
  State<TabResponse> createState() => _TabResponseState();
}

class _TabResponseState extends State<TabResponse> {
  final List<String> items = [
    'Mới nhất',
    'Cũ nhất',
  ];
  String? selectedValue;
  bool isNewest = true;

  @override
  void initState() {
    super.initState();
    selectedValue = items[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (!isNewest) {
      widget.feedbacks.sort((a, b) => a.time.compareTo(b.time));
    } else {
      widget.feedbacks.sort((b, a) => a.time.compareTo(b.time));
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Text(
                'Có ${widget.feedbacks.length} phản hồi',
                style: const TextStyle(fontSize: 18),
              ),
              const Spacer(),
              // box filter
              Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.Black),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      selectedValue!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                        isNewest = selectedValue == 'Mới nhất' ? true : false;
                      });
                    },
                    buttonHeight: 35,
                    buttonWidth: 120,
                    itemHeight: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: size.height,
          width: size.width,
          child: ListView.builder(
            itemCount: widget.feedbacks.length,
            itemBuilder: (context, index) {
              f.Feedback feedback = widget.feedbacks[index];
              return ItemFeedback(feedback: feedback);
            },
          ),
        )
      ],
    );
  }
}
