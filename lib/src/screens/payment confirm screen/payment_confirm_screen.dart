import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import 'package:image_picker/image_picker.dart';

class PaymentConfirmScreen extends StatefulWidget {
  const PaymentConfirmScreen({Key? key}) : super(key: key);

  @override
  State<PaymentConfirmScreen> createState() => _PaymentConfirmScreenState();
}

class _PaymentConfirmScreenState extends State<PaymentConfirmScreen> {
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  // controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool isEmptyName = false,
      isEmptyAccountNumber = false,
      isEmptyBankName = false,
      isEmptyContent = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFCF6F6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFDB2F68),
        title: const Text(
          "Thanh toán hóa đơn",
          style: TextStyle(
            color: AppColors.White,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.White,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: height * 0.04,
            left: width * 0.055,
            right: width * 0.055,
            bottom: height * 0.01),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: height * 0.02,
              ),
              child: Text(
                "Cung cấp ảnh chụp màn hình minh chứng sau khi đã chuyển khoản",
                style: AppTextStyle.lato.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            InkWell(
              onTap: _showModalBottomSheet,
              child: Container(
                height: height * 0.6,
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF806D6D),
                    width: 1,
                  ),
                ),
                child: _imageFile == null
                    ? Image.asset(
                        "assets/image-picker.png",
                      )
                    : Image.asset(
                        _imageFile!.path,
                      ),
              ),
            ),
            SizedBox(height: height * 0.01),
            InkWell(
              onTap: () {
                setState(() {
                  isEmptyName = nameController.text.isEmpty;
                  isEmptyAccountNumber = accountNumberController.text.isEmpty;
                  isEmptyBankName = bankNameController.text.isEmpty;
                  isEmptyContent = contentController.text.isEmpty;
                });
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.White,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.Black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Xác nhận",
                    style: TextStyle(
                      color: AppColors.Black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
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
                  child: Text("Chỉnh sửa ảnh đại diện",
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
    // final _pickedFile = await _picker.getImage(source: source);
    // if (_pickedFile != null) {
    //   setState(() {
    //     _imageFile = _pickedFile;
    //     uploadImage(_imageFile!);
    //   });
    // }
  }

  // upload _imageFile to api
  // void uploadImage(PickedFile _imageFile) async {
  //   final user = context.read<ProfileProvider>().mdUser;
  //   final _image = File(_imageFile.path);
  //   Uint8List avatar = await _image.readAsBytes();
  //   String imageUrl = await StorageMethods()
  //       .uploadImageToStorage('profilePics', avatar, false, user.idNumber);
  //   print('url anh: $imageUrl');

  //   await ProfilePro().updateProfilePictureAPIProvider(imageUrl);
  //   context.read<ProfileProvider>().setProfilePicture(imageUrl);
  // }
}
