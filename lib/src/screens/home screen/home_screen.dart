import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/bill_provider.dart';
import 'package:untitled/src/providers/feedback_provider.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/screens/logout%20screen/logout_confirm_dialog.dart';
import '../../../utils/app_constant/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final feedbackProvider = Provider.of<FeedbackProvider>(
      context,
      listen: false,
    );
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    final billProvider = Provider.of<BillProvider>(
      context,
      listen: false,
    );
    feedbackProvider.getUserFeedback();
    profileProvider.getCurrentUserProfile();
    profileProvider.getProfilePicture();
    billProvider.getAllEAndWBill();
    billProvider.getAllServiceBill();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.White,
      child: Center(
        child: ElevatedButton(
          onPressed: () => showLogoutConfirmPopupDialog(context, height, width),
          child: const Text("Show confirm logout popup"),
        ),
      ),
    );
  }

  void showLogoutConfirmPopupDialog(BuildContext context, height, width) =>
      showDialog(
          context: context, builder: ((context) => LogOutConfirmDialog()));
}
