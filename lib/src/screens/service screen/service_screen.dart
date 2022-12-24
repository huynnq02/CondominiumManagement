import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/models/user_service.dart';
import 'package:untitled/src/providers/apartment_service_provider.dart';
import 'package:untitled/src/providers/user_service_provider.dart';
import 'package:untitled/src/screens/service%20screen/widgets/tab_services_all.dart';
import 'package:untitled/src/screens/service%20screen/widgets/tab_services_using.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var apartmentServiceProvider = context.watch<ApartmentServiceProvider>();
    var userServiceProvider = context.watch<UserServiceProvider>();

    List<ApartmentService> apartmentServices =
        apartmentServiceProvider.services;
    List<UserService> userServices = userServiceProvider.services;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDB2F68),
        elevation: 0,
        title: Text(
          'Dịch vụ',
          style: AppTextStyle.lato.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color(0xFFFCF6F6),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xFFEDEDED),
                ),
                child: TabBar(
                  controller: tabController,
                  labelStyle: AppTextStyle.lato.copyWith(
                    fontSize: 17,
                  ),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xFFDB2F68),
                  ),
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF909090),
                  tabs: const [
                    Tab(text: 'Tất cả'),
                    Tab(text: 'Đang dùng'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    TabServicesAll(
                      services: apartmentServices,
                    ),
                    const TabServicesUsing(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
