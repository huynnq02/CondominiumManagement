import 'package:flutter/material.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/drop_down_menu.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/apartment_bill.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/service_bill.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class BillScreen extends StatefulWidget {
  BillScreen({Key? key}) : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.05),
                child: Center(
                  child: Text(
                    "Hóa đơn",
                    style: AppTextStyle.montserrat.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                height: height * 0.05,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: TabBar(
                    controller: tabController,
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          "Hóa đơn căn hộ",
                          style: AppTextStyle.montserrat.copyWith(
                            fontSize: 14,
                            color: const Color(0xFF1D6D54),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Hóa đơn dịch vụ",
                          style: AppTextStyle.montserrat.copyWith(
                            fontSize: 14,
                            color: const Color(0xFF1D6D54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Có 6 hóa đơn",
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 14,
                      color: const Color(0xFF1D6D54),
                    ),
                  ),
                  DropDownMenu(),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    AparmentBilll(),
                    ServiceBill(),
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
