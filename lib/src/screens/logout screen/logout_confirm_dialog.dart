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

    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 22, bottom: 17, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Bạn có chắc chắn muốn đăng xuất không?",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.Pink),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(
                        width * 0.324,
                        35,
                      ),
                      side:
                          const BorderSide(color: Color(0xFFD9D9D9), width: 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: const Text(
                      "KHÔNG",
                      style: TextStyle(
                          color: Color(0xFF625E5E),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
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
                        backgroundColor: AppColors.DarkPink,
                        fixedSize: Size(
                          width * 0.324,
                          35,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        shadowColor: Colors.transparent),
                    child: const Text(
                      "CHẮC CHẮN",
                      style: TextStyle(
                          color: AppColors.White,
                          fontSize: 12,
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