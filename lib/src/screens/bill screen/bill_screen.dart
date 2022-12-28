import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/bill_provider.dart';
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

  // void setDefaultTab() {
  //   Provider.of<BillProvider>(context, listen: false).setCurrentTab(0);
  // }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  int getNumOfBills(int index, BuildContext context) {
    if (index == 0) {
      if (Provider.of<BillProvider>(context).billState == "Tất cả") {
        return Provider.of<BillProvider>(context, listen: false)
            .apartmentBills
            .length;
      } else if (Provider.of<BillProvider>(context).billState ==
          "Chưa thanh toán") {
        return Provider.of<BillProvider>(context, listen: false)
            .unpaidApartmentBills
            .length;
      } else if (Provider.of<BillProvider>(context).billState ==
          "Đã thanh toán") {
        return Provider.of<BillProvider>(context, listen: false)
            .paidApartmentBills
            .length;
      } else if (Provider.of<BillProvider>(context).billState ==
          "Từ chối thanh toán") {
        return Provider.of<BillProvider>(context, listen: false)
            .refuseApartmentBills
            .length;
      } else {
        return Provider.of<BillProvider>(context, listen: false)
            .waitingApartmentBills
            .length;
      }
    } else {
      if (Provider.of<BillProvider>(context).billState == "Tất cả") {
        return Provider.of<BillProvider>(context, listen: false)
            .serviceBills
            .length;
      } else if (Provider.of<BillProvider>(context).billState ==
          "Chưa thanh toán") {
        return Provider.of<BillProvider>(context, listen: false)
            .unpaidServiceBills
            .length;
      } else if (Provider.of<BillProvider>(context).billState ==
          "Đã thanh toán") {
        return Provider.of<BillProvider>(context, listen: false)
            .paidServiceBills
            .length;
      } else if (Provider.of<BillProvider>(context).billState ==
          "Từ chối thanh toán") {
        return Provider.of<BillProvider>(context, listen: false)
            .refuseServiceBills
            .length;
      } else {
        return Provider.of<BillProvider>(context, listen: false)
            .waitingServiceBills
            .length;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFCF6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDB2F68),
        elevation: 0,
        title: Text(
          "Hóa đơn",
          style: AppTextStyle.montserrat.copyWith(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
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
                  onTap: (index) {
                    Provider.of<BillProvider>(context, listen: false)
                        .setCurrentTab(index);
                  },
                  controller: tabController,
                  labelStyle: AppTextStyle.lato.copyWith(
                    fontSize: 14,
                  ),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFDB2F68),
                  ),
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF979A9C),
                  // set liner gradient color to background of unselected tab

                  tabs: const [
                    Tab(
                      child: Text(
                        "Hóa đơn căn hộ",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Hóa đơn dịch vụ",
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
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Có ",
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      TextSpan(
                        text:
                            "${getNumOfBills(Provider.of<BillProvider>(context).currentTab, context)} ",
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFFDB2F68),
                        ),
                      ),
                      TextSpan(
                        text: "hóa đơn",
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ),
                const DropDownMenu(),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  AparmentBill(),
                  ServiceBill(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
