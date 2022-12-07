import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/models/user_service.dart';
import 'package:untitled/src/providers/apartment_service_provider.dart';
import 'package:untitled/src/providers/user_service_provider.dart';
import 'package:untitled/src/screens/service%20screen/widgets/item_service.dart';
import 'package:untitled/src/screens/service%20screen/widgets/tab_services_all.dart';
import 'package:untitled/src/screens/service%20screen/widgets/tab_services_using.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Dịch vụ',
          style: AppTextStyle.lato,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
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
                    color: Colors.white,
                  ),
                  indicatorColor: Colors.transparent,
                  labelColor: const Color(0xFF1D6D54),
                  tabs: const [
                    Tab(text: 'Tất cả'),
                    Tab(text: 'Đang dùng'),
                  ],
                  onTap: (value) {
                    setState(
                      () {
                        tabIndex = value;
                      },
                    );
                  },
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
                    TabServicesUsing(
                      services: userServices,
                    ),
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
