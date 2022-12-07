// import 'package:flutter/material.dart';
// import 'package:untitled/src/models/bill.dart';
// import 'package:untitled/src/screens/bill%20detail%20screen/widgets/row_data.dart';
// import 'package:untitled/utils/app_constant/app_colors.dart';
// import 'package:untitled/utils/app_constant/app_text_style.dart';
// import 'package:untitled/utils/helper/string_extensions.dart';

// class AparmentBilllDetail extends StatelessWidget {
//   final AparmentBilll? AparmentBilll;
//   final ManageBill? manageBill;
//   const AparmentBilllDetail({Key? key, this.AparmentBilll, this.manageBill})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Chi tiết hóa đơn",
//           style: TextStyle(
//             color: AppColors.White,
//           ),
//         ),
//         backgroundColor: const Color(0xFF1D6D54),
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: AppColors.White,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(
//             top: height * 0.02,
//             left: width * 0.05,
//             right: width * 0.05,
//             bottom: height * 0.02),
//         child: Column(
//           children: [
//             if (AparmentBilll!.state == "Chưa thanh toán")
//               Padding(
//                 padding: EdgeInsets.only(
//                   bottom: height * 0.02,
//                 ),
//                 child: Text(
//                   "Quý khách đến văn phòng ban quản lý vui lòng xuất trình chi tiết hóa đơn trước khi thanh toán",
//                   style: AppTextStyle.lato.copyWith(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: AparmentBilll!.state == "Chưa thanh toán"
//                       ? AppColors.Black
//                       : AparmentBilll!.state == "Đã thanh toán"
//                           ? const Color(0xFF2AC956)
//                           : const Color(0xFF5C92FE),
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   top: height * 0.03,
//                   left: width * 0.03,
//                   right: width * 0.03,
//                   bottom: height * 0.02,
//                 ),
//                 child: Column(
//                   children: [
//                     RowDetail(
//                         title: "Mã hóa đơn", data: AparmentBilll!.billID!),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: height * 0.01, bottom: height * 0.01),
//                       child: const Divider(
//                         color: Color.fromRGBO(0, 0, 0, 0.5),
//                         thickness: 1,
//                       ),
//                     ),
//                     RowDetail(
//                         title: "Tên hóa đơn", data: AparmentBilll!.billName),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: height * 0.01, bottom: height * 0.01),
//                       child: const Divider(
//                         color: Color.fromRGBO(0, 0, 0, 0.5),
//                         thickness: 1,
//                       ),
//                     ),
//                     RowDetail(
//                         title: "Mã căn hộ", data: AparmentBilll!.apartmentID),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: height * 0.01, bottom: height * 0.01),
//                       child: const Divider(
//                         color: Color.fromRGBO(0, 0, 0, 0.5),
//                         thickness: 1,
//                       ),
//                     ),
//                     RowDetail(
//                       title: "Kỳ hóa đơn",
//                       data: AparmentBilll!.paymentTerm
//                           .formatDateTime()
//                           .substring(AparmentBilll!.paymentTerm
//                                   .formatDateTime()
//                                   .length -
//                               7),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: height * 0.01, bottom: height * 0.01),
//                       child: const Divider(
//                         color: Color.fromRGBO(0, 0, 0, 0.5),
//                         thickness: 1,
//                       ),
//                     ),
//                     RowDetail(
//                       title: "Hạn đóng",
//                       data: AparmentBilll!.paymentTerm.formatDateTime(),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: height * 0.01, bottom: height * 0.01),
//                       child: const Divider(
//                         color: Color.fromRGBO(0, 0, 0, 0.5),
//                         thickness: 1,
//                       ),
//                     ),
//                     RowDetail(
//                       title: "Số tiền thanh toán",
//                       data: AparmentBilll!.price,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
