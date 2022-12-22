import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/src/models/feedback.dart' as fb;
import 'package:untitled/src/providers/feedback_provider.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/screens/create%20feedback/widgets/feedback_input.dart';
import 'package:untitled/src/screens/create%20feedback/widgets/feedback_type_widget.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class CreateFeedbackScreen extends StatefulWidget {
  const CreateFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<CreateFeedbackScreen> createState() => _CreateFeedbackScreenState();
}

int _selectedIndex = 1;

class _CreateFeedbackScreenState extends State<CreateFeedbackScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool? isEmptyTitle, isEmptyContent;
  PickedFile? _imageFile;
  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    profileProvider.getCurrentUserProfile();
    getEmail();
  }

  void getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('userID'));
  }

  void validateInput() {
    if (_titleController.text.trim().isEmpty) {
      setState(() {
        isEmptyTitle = true;
      });
    } else {
      setState(() {
        isEmptyTitle = false;
      });
    }
    if (_contentController.text.trim().isEmpty) {
      setState(() {
        isEmptyContent = true;
      });
    } else {
      setState(() {
        isEmptyContent = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final feedbackProvider =
        Provider.of<FeedbackProvider>(context, listen: true);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC7E2D1),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: feedbackProvider.isLoading == false
              ? const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.White,
                )
              : null,
        ),
        title: Stack(
          children: [
            Text(
              "Tạo ý kiến",
              style: AppTextStyle.tomorrow.copyWith(
                fontSize: 30,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = AppColors.Black,
              ),
            ),
            Text(
              "Tạo ý kiến",
              style: AppTextStyle.tomorrow.copyWith(
                fontSize: 30,
                color: AppColors.White,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 15),
            child: GestureDetector(
              onTap: () {
                validateInput();
                if (isEmptyContent != null &&
                    isEmptyContent != true &&
                    isEmptyTitle != null &&
                    isEmptyTitle != true) {
                  // print feedback data

                  fb.Feedback feedback = fb.Feedback(
                    email: profileProvider.mdUser.email,
                    time: DateTime.now().toIso8601String(),
                    image: "",
                    type: _selectedIndex == 1
                        ? "Lỗi/sự cố"
                        : _selectedIndex == 2
                            ? "Phàn nàn"
                            : "Thắc mắc",
                    title: _titleController.text.standardlizeString(),
                    status: "Chưa phản hồi",
                    content: _contentController.text.standardlizeString(),
                    respond: "",
                  );
                  print("email: ${feedback.email}");
                  print("title: ${feedback.title}");
                  print("content: ${feedback.content}");
                  print("time: ${feedback.time}");
                  print("type: ${feedback.type}");
                  print("status: ${feedback.status}");
                  print("respond: ${feedback.respond}");
                  print("image: ${feedback.image}");

                  feedbackProvider.createUserFeedback(
                    context,
                    feedback,
                  );
                }
              },
              child: feedbackProvider.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      "Gửi",
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: AppColors.White,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
            ),
          )
        ],
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFC7E2D1),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.0001,
            ),
            SizedBox(
              width: width * 0.7,
              child: const Divider(
                thickness: 1,
                color: Color.fromRGBO(0, 0, 0, 0.3),
              ),
            ),
            SizedBox(
              height: height * 0.005,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.White,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Text(
                                "Loại ý kiến",
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              Text(
                                "Loại ý kiến",
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 20,
                                  color: Colors.black,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 1;
                                });
                              },
                              child: FeedBackType(
                                title: "Lỗi/sự cố",
                                colorOntap:
                                    const Color.fromRGBO(255, 0, 0, 0.5),
                                selectedIndex: _selectedIndex,
                                index: 1,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 2;
                                });
                              },
                              child: FeedBackType(
                                title: "Phàn nàn",
                                colorOntap:
                                    const Color.fromRGBO(245, 125, 0, 0.5),
                                selectedIndex: _selectedIndex,
                                index: 2,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 3;
                                });
                              },
                              child: FeedBackType(
                                title: "Thắc mắc",
                                colorOntap:
                                    const Color.fromRGBO(0, 0, 255, 0.5),
                                selectedIndex: _selectedIndex,
                                index: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Tiêu đề",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        FeedbackInput(
                          height: height,
                          width: width,
                          hintText: "Nhập tiêu đề",
                          maxLength: 100,
                          controller: _titleController,
                          isError: isEmptyTitle,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        if (isEmptyTitle == true)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Vui lòng nhập tiêu đề",
                              style: AppTextStyle.lato.copyWith(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Nội dung",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          height: height * 0.2,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            color: AppColors.White,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: AppColors.Black,
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 2),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: _showModalBottomSheet,
                            child: _imageFile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(
                                        _imageFile!.path,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.image,
                                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                                    size: height * 0.1,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        FeedbackInput(
                          height: height,
                          width: width,
                          hintText: "Nhập nội dung",
                          maxLength: 300,
                          controller: _contentController,
                          isError: isEmptyContent,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        if (isEmptyContent == true)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Vui lòng nhập nội dung",
                              style: AppTextStyle.lato.copyWith(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset(
                            "assets/apato-logo.png",
                            height: height * 0.15,
                            fit: BoxFit.fill,
                          ),
                        ),
                        // Stack(
                        //   children: [
                        //     Positioned(
                        //       left: -100,
                        //       child: Image.asset(
                        //         "assets/icon-message-left.png",
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     Positioned(
                        //       child: Image.asset(
                        //         "assets/icon-message-right.png",
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     Positioned(
                        //       child: Image.asset(
                        //         "assets/apato-logo.png",
                        //         height: height * 0.2,
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (builder) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return Container(
          height: height * 0.197,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: height * 0.065,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.White,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Chọn phương thức",
                    style: AppTextStyle.lato
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.001,
              ),
              Container(
                height: height * 0.065,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.White,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.camera_alt,
                              size: 29,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Chụp ảnh",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 16,
                              color: const Color(0xFF12C82F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      takePhoto(ImageSource.camera);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.001,
              ),
              Container(
                height: height * 0.065,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.White,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: ImageIcon(
                              AssetImage('assets/galery-icon.png'),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Chọn từ thư viện ảnh",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 16,
                              color: const Color(0xFF12C82F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void takePhoto(ImageSource source) async {
    final _pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = _pickedFile;
    });
    Navigator.pop(context);
  }
}
