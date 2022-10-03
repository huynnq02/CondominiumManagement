import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/screens/register%20screen/register_screen.dart';

import '../../../utils/app_constant/app_colors.dart';
import '../../../utils/app_constant/app_text_style.dart';
import '../../providers/register_provider.dart';

class ConfirmRegisterScreen extends StatefulWidget {
  MDUser mdUser;
  ConfirmRegisterScreen({Key? key, required this.mdUser}) : super(key: key);

  @override
  State<ConfirmRegisterScreen> createState() => _ConfirmRegisterScreenState();
}

class _ConfirmRegisterScreenState extends State<ConfirmRegisterScreen> {
  RegisterProvider? provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<RegisterProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox.expand(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 78,
                          ),
                          Image.asset('assets/logo.png'),
                          const SizedBox(
                            height: 73,
                          ),
                          Text(
                            'Đăng kí tài khoản mới',
                            style: AppTextStyle.nunitoSize13.copyWith(
                                fontSize: 18,
                                color: AppColors.Blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              height: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Để hoàn thành đăng kí tài khoản, xin vui lòng truy cập ${widget.mdUser.email} và xác thực email (lưu ý kiểm tra Spam/Junk) ',
                                    style: AppTextStyle.nunitoSize13.copyWith(
                                        fontSize: 15, color: AppColors.Black),
                                  ),
                                  Text(
                                      'Nếu bạn chưa nhận được email xác thực, hãy chọn \'Gửi lại email xác thực\' ',
                                      style: AppTextStyle.nunitoSize13.copyWith(
                                          fontSize: 15, color: AppColors.Black))
                                ],
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Bạn muốn thay đổi email đăng kí! ',
                                style: AppTextStyle.nunitoBoldSize14
                                    .copyWith(fontSize: 12),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: ((context) {
                                      return const RegisterScreen();
                                    })));
                                  },
                                  child: Text('Chọn vào đây',
                                      style: AppTextStyle.nunitoBoldSize14
                                          .copyWith(
                                              fontSize: 13,
                                              color: AppColors.Blue)))
                            ],
                          ),
                          SizedBox(
                            width: 352,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColors.Blue),
                              onPressed: () {
                                // provider!
                                //     .sendEmail(widget.mdUser.email.toString());
                              },
                              child: Text(
                                'Đăng kí',
                                style: AppTextStyle.nunitoSize13.copyWith(
                                    color: AppColors.White,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                Image.asset('assets/slide2.png')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
