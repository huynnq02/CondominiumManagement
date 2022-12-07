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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
