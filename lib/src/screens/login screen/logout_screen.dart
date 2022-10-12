import 'package:flutter/material.dart';
import 'package:untitled/src/screens/login%20screen/login_screen.dart';
import '../../../utils/app_constant/app_colors.dart';
import 'package:untitled/src/screens/login%20screen/login_screen.dart';

class LogoutTemp extends StatefulWidget {
  const LogoutTemp({Key? key}) : super(key: key);

  @override
  State<LogoutTemp> createState() => _LogoutTempState();
}

class _LogoutTempState extends State<LogoutTemp> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: ElevatedButton(
        onPressed: () => showLogoutConfirmPopupDialog(context, height, width),
        child: const Text("Show confirm logout popup"),
      ),
    );
  }

  void showLogoutConfirmPopupDialog(BuildContext context, height, width) =>
      showDialog(
        context: context,
        builder: ((context) => Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                height: height * 0.18,
                width: width * 0.8,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 17, left: 8, right: 8),
                    child: Column(
                      children: [
                        const Text(
                          "Bạn có chắc chắn không?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.023,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.LogoutButtonColor,
                                fixedSize: Size(
                                  width * 0.28,
                                  height * 0.035,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                ),
                              ),
                              child: const Text(
                                "Đăng xuất",
                                style: TextStyle(
                                    color: AppColors.White, fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.08,
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.Black,
                                fixedSize: Size(
                                  width * 0.28,
                                  height * 0.035,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                ),
                              ),
                              child: const Text(
                                "Hủy",
                                style: TextStyle(
                                    color: AppColors.White, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      );
}
