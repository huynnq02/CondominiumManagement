import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/providers/bill_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import 'package:image_picker/image_picker.dart';

class PaymentConfirmScreen extends StatefulWidget {
  final ServiceBill? serviceBill;
  final ApartmentBill? apartmentBill;
  const PaymentConfirmScreen({Key? key, this.apartmentBill, this.serviceBill})
      : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    BillProvider billProvider = Provider.of<BillProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print("id ne");
    widget.apartmentBill != null
        ? print(widget.apartmentBill!.id)
        : print(widget.serviceBill);
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
      body: SingleChildScrollView(
        child: Padding(
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
                      : Image.asset(
                          "assets/image-picker.png",
                        ),
                ),
              ),
              SizedBox(height: height * 0.05),
              billProvider.isLoading
                  ? const CircularProgressIndicator()
                  : InkWell(
                      onTap: () {
                        if (widget.apartmentBill != null &&
                            _imageFile != null) {
                          Provider.of<BillProvider>(context, listen: false)
                              .editApartmentBill(
                            context,
                            _imageFile!,
                            widget.apartmentBill!,
                          );
                        } else if (widget.serviceBill != null &&
                            _imageFile != null) {
                          Provider.of<BillProvider>(context, listen: false)
                              .editServiceBill(
                            context,
                            _imageFile!,
                            widget.serviceBill!,
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFDB2F68),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.only(
                            left: width * 0.35,
                            right: width * 0.35,
                            top: height * 0.015,
                            bottom: height * 0.015),
                        child: Text(
                          "Xác nhận",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 15,
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
            ],
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
    if (_pickedFile != null) {
      setState(() {
        _imageFile = _pickedFile;
      });
    }
    Navigator.pop(context);
  }
}
