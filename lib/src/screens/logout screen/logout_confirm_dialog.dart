import 'package:flutter/material.dart';
import 'package:untitled/src/providers/feedback_provider.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/screens/login%20screen/login_screen.dart';
import '../../../utils/app_constant/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/src/providers/login_provider.dart';
import '../../providers/repository_provider.dart';
import 'package:provider/provider.dart';

class LogOutConfirmDialog extends StatefulWidget {
  LogOutConfirmDialog({Key? key}) : super(key: key);

  @override
  State<LogOutConfirmDialog> createState() => _LogOutConfirmDialogState();
}

class _LogOutConfirmDialogState extends State<LogOutConfirmDialog> {
  late LoginProvider loginProvider;

  late RepositoryProvider getPhonesProvider;
  Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context, listen: false);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Bạn có muốn đăng xuất?",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.Purple),
              ),
              const SizedBox(
                height: 51,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(
                        width * 0.28,
                        29,
                      ),
                      side:
                          const BorderSide(color: Color(0xFF625E5E), width: 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                    child: const Text(
                      "Không",
                      style: TextStyle(
                          color: Color(0xFF625E5E),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileProvider>().setEmptyUser();
                      context.read<FeedbackProvider>().setEmptyFeedback();
                      removeToken(); //remove token khi đăng xuất
                      loginProvider.check = false;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.Purple,
                      fixedSize: Size(
                        width * 0.28,
                        29,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                    child: const Text(
                      "Có",
                      style: TextStyle(
                          color: AppColors.White,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
