import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/repository/service/serviceAPI_provider.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/models/user_service.dart';
import 'package:untitled/src/providers/feedback_provider.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/providers/apartment_service_provider.dart';
import 'package:untitled/src/providers/user_service_provider.dart';
import 'package:untitled/src/screens/logout%20screen/logout_confirm_dialog.dart';

import '../../../utils/app_constant/app_colors.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/screens/home screen/widgets/custom_button.dart';
import 'package:untitled/src/screens/home%20screen/widgets/home_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    getFeedback();
    getCurrentUserProfile();
    getProfilePicture();
    getServices();
    getUsingServices();
  }

  void getFeedback() async {
    final feedbackProvider = Provider.of<FeedbackProvider>(
      context,
      listen: false,
    );
    await feedbackProvider.getUserFeedback();
  }

  void getCurrentUserProfile() async {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    await profileProvider.getCurrentUserProfile();
  }

  void getProfilePicture() async {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    await profileProvider.getProfilePicture();
  }

  void getServices() async {
    final ServicePro servicePro = ServicePro();
    List<ApartmentService> services = await servicePro.getApartmentServices();
    context.read<ApartmentServiceProvider>().setListServices(services);
    print('services : $services');
  }

  void getUsingServices() async {
    final ServicePro servicePro = ServicePro();
    List<UserService> services = await servicePro.getUserServices();
    context.read<UserServiceProvider>().setListServices(services);
    print('services : $services');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileProvider>(context);
    if (user.mdUser.apartmentId == '') {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.White,
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Xin chào! ${user.mdUser.surname + user.mdUser.name}',
                style: TextStyle(fontSize: 15, shadows: [
                  Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 4)
                ]),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                user.mdUser.apartmentId != null
                    ? 'Tòa ${user.mdUser.apartmentId?.split('.')[0]} - ${user.mdUser.apartmentId?.split('.')[1]}'
                    : 'Account không có apartmentId',
                style: const TextStyle(fontSize: 12),
              )
            ],
          )),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 22, bottom: 86),
            child: Column(children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 30,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 19),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4)
                    ]),
                child: Column(
                  children: [
                    Text(
                      'Tổng thanh toán tháng ${now.month}/${now.year}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: '1.690.000',
                              style: TextStyle(
                                  fontSize: 36,
                                  color: const Color(0xFFFF8A00),
                                  shadows: [
                                    Shadow(
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4)
                                  ])),
                          const TextSpan(
                              text: ' vnđ',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          label: 'Chi tiết',
                          onPressed: () {},
                        ),
                        CustomButton(
                          label: 'Thanh toán',
                          onPressed: () {},
                          backgroundColor: const Color(0xFF5FC5FF),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 46),
              CustomButton(
                label: 'Chung cư APATO',
                onPressed: () {},
                width: 240,
                backgroundColor: const Color(0xFFFFC000),
              ),
              const SizedBox(
                height: 42,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    HomeItem(
                      title: 'Ban quản lý',
                      iconPath: 'assets/home_icons/office-building.png',
                    ),
                    HomeItem(
                      title: 'Nội quy',
                      iconPath: 'assets/home_icons/rules.png',
                    ),
                    HomeItem(
                      title: 'Bảng tin',
                      iconPath: 'assets/home_icons/newspaper.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 47,
              ),
              CustomButton(
                label: 'Các tính năng thường dùng',
                onPressed: () {},
                width: 240,
                backgroundColor: const Color(0xFFFFC000),
              ),
              const SizedBox(
                height: 42,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    HomeItem(
                      title: 'Đăng ký khách',
                      iconPath: 'assets/home_icons/guest-list.png',
                    ),
                    HomeItem(
                      title: 'Giặt ủi',
                      iconPath: 'assets/home_icons/laundry-machine.png',
                    ),
                    HomeItem(
                      title: 'Góp ý',
                      iconPath: 'assets/home_icons/feedback.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    HomeItem(
                      title: 'Đăng ký thẻ xe',
                      iconPath: 'assets/home_icons/credit.png',
                    ),
                    HomeItem(
                      title: 'Đăng ký phòng gym',
                      iconPath: 'assets/home_icons/gym.png',
                    ),
                    HomeItem(
                      title: 'Đăng ký vệ sinh phòng',
                      iconPath: 'assets/home_icons/cleaning.png',
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    }
  }
}
