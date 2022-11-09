import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class CreateFeedbackScreen extends StatefulWidget {
  const CreateFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<CreateFeedbackScreen> createState() => _CreateFeedbackScreenState();
}

int _selectedIndex = 1;

class _CreateFeedbackScreenState extends State<CreateFeedbackScreen> {
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: const Color(0xFF57E4A9).withOpacity(0.3),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: statusBarHeight,
                // ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.White,
                        ),
                      ),
                      Stack(
                        children: [
                          Text(
                            "Tạo ý kiến",
                            style: AppTextStyle.tomorrow.copyWith(
                              fontSize: 25,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = AppColors.Black,
                            ),
                          ),
                          Text(
                            "Tạo ý kiến",
                            style: AppTextStyle.tomorrow.copyWith(
                              fontSize: 25,
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
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Gửi",
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
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
                      )
                    ],
                  ),
                ),
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
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.White,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
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
                              child: Container(
                                height: height * 0.05,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  color: _selectedIndex == 1
                                      ? const Color.fromRGBO(255, 0, 0, 0.5)
                                      : const Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(20),
                                  // set border for container
                                  border: Border.all(
                                    color: AppColors.Black.withOpacity(0.5),
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
                                child: Center(
                                  child: Text(
                                    'Lỗi/sự cố',
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: _selectedIndex == 1
                                          ? AppColors.White
                                          : AppColors.Black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 2;
                                });
                              },
                              child: Container(
                                height: height * 0.05,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  color: _selectedIndex == 2
                                      ? const Color.fromRGBO(245, 125, 0, 0.5)
                                      : const Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.Black.withOpacity(0.5),
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
                                child: Center(
                                  child: Text(
                                    'Phàn nàn',
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: _selectedIndex == 2
                                          ? AppColors.White
                                          : AppColors.Black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 3;
                                });
                              },
                              child: Container(
                                height: height * 0.05,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  color: _selectedIndex == 3
                                      ? const Color.fromRGBO(143, 0, 255, 1)
                                      : const Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.Black.withOpacity(0.5),
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
                                child: Center(
                                  child: Text(
                                    'Thắc mắc',
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: _selectedIndex == 3
                                          ? AppColors.White
                                          : AppColors.Black,
                                    ),
                                  ),
                                ),
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
                        OpinionInput(
                          height: height,
                          width: width,
                          hintText: "Nhập tiêu đề",
                          maxLength: 100,
                        ),
                        SizedBox(
                          height: height * 0.02,
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
                                ? Image.file(
                                    File(_imageFile!.path),
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
                        OpinionInput(
                          height: height,
                          width: width,
                          hintText: "Nhập nội dung",
                          maxLength: 300,
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              // bottom: 150,
                              top: -15,
                              left: -width * 0.25,
                              child: Image.asset(
                                "assets/icon-message-left.png",
                                height: height * 0.07,
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: -width * 0.25,
                              child: Image.asset(
                                "assets/icon-message-right.png",
                                height: height * 0.07,
                              ),
                            ),
                            Positioned(
                              child: Image.asset(
                                "assets/apato-logo.png",
                                height: height * 0.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
                  child:
                      Text("", style: AppTextStyle.lato.copyWith(fontSize: 16)),
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

class OpinionInput extends StatelessWidget {
  OpinionInput(
      {Key? key,
      required this.height,
      required this.width,
      required this.hintText,
      required this.maxLength})
      : super(key: key);
  String hintText;
  int maxLength;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: TextField(
            textAlign: TextAlign.justify,
            maxLength: maxLength,
            maxLines: 3,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(0),
              hintText: hintText,
              hintStyle: AppTextStyle.lato.copyWith(
                fontSize: 18,
                color: AppColors.Black.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
