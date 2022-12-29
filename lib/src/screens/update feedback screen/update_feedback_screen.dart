import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/feedback.dart' as fb;
import 'package:untitled/src/providers/feedback_provider.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/screens/create%20feedback/widgets/feedback_input.dart';
import 'package:untitled/src/screens/create%20feedback/widgets/feedback_type_widget.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/show_snack_bar.dart';
import 'package:untitled/utils/helper/storage_methods.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class UpdateFeedbackScreen extends StatefulWidget {
  final fb.Feedback feedback;
  const UpdateFeedbackScreen({Key? key, required this.feedback})
      : super(key: key);

  @override
  State<UpdateFeedbackScreen> createState() => _UpdateFeedbackScreenState();
}

class _UpdateFeedbackScreenState extends State<UpdateFeedbackScreen> {
  late int _selectedIndex;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool? isEmptyTitle, isEmptyContent;
  XFile? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.feedback.type == "Lỗi/ Sự cố"
        ? 1
        : widget.feedback.type == "Phàn nàn"
            ? 2
            : 3;
    _titleController.text = widget.feedback.title;
    _contentController.text = widget.feedback.content;
    _imageUrl = widget.feedback.image;

    print(widget.feedback.image);
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
        backgroundColor: const Color(0xFFDB2F68),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.White,
          ),
        ),
        title: const Text(
          'Chỉnh sửa ý kiến',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFCF6F6),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Loại ý kiến",
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
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
                        colorOntap: const Color(0xFFDB2F68),
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
                        colorOntap: const Color(0xFFDB2F68),
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
                        colorOntap: const Color(0xFFDB2F68),
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
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                FeedbackInput(
                  height: height,
                  width: width,
                  hintText: "Nhập tiêu đề",
                  maxLength: 100,
                  controller: _titleController,
                  isError: isEmptyTitle,
                ),
                SizedBox(height: height * 0.01),
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
                SizedBox(height: height * 0.005),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Nội dung",
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
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
                SizedBox(height: height * 0.01),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Hình ảnh đính kèm",
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Container(
                  height: height * 0.2,
                  width: width * 0.9,
                  decoration: const BoxDecoration(
                    color: AppColors.White,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
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
                              File(_imageFile!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : widget.feedback.image == "" ||
                                widget.feedback.image == null
                            ? Icon(
                                Icons.image,
                                color: const Color.fromRGBO(0, 0, 0, 0.2),
                                size: height * 0.1,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  widget.feedback.image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDB2F68),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    final user = context.read<ProfileProvider>().mdUser;
                    validateInput();
                    if (isEmptyContent != null &&
                        isEmptyContent != true &&
                        isEmptyTitle != null &&
                        isEmptyTitle != true) {
                      fb.Feedback feedback = fb.Feedback(
                        id: widget.feedback.id,
                        email: user.email,
                        time: DateTime.now().toIso8601String(),
                        image: _imageUrl,
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
                      feedbackProvider.editFeedback(feedback);
                      Navigator.of(context).pop();

                      showSnackBar(
                        context,
                        "Cập nhật ý kiến thành công!",
                      );
                    }
                  },
                  child: Center(
                    child: Text(
                      'Cập nhật',
                      style: AppTextStyle.lato.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
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
                  child: Text("Chọn phương thức",
                      style: AppTextStyle.lato.copyWith(fontSize: 16)),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.1),
                            child: const ImageIcon(
                              AssetImage('assets/camera-icon.png'),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Chụp ảnh",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 16,
                              color: const Color(0xFFD0255E),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.1),
                            child: const ImageIcon(
                              AssetImage('assets/gallery-icon.png'),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Chọn từ thư viện ảnh",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 16,
                              color: const Color(0xFFD0255E),
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
    final user = context.read<ProfileProvider>().mdUser;
    final _pickedFile = await _picker.pickImage(source: source);
    if (_pickedFile != null) {
      final _image = File(_pickedFile.path);
      Uint8List feedbackImg = await _image.readAsBytes();
      String imageUrl = await StorageMethods()
          .uploadImageToStorage('feedbacks', feedbackImg, true, user.idNumber);

      setState(() {
        _imageFile = _pickedFile;
        _imageUrl = imageUrl;
      });
    }

    Navigator.pop(context);
  }
}
