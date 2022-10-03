import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/src/screens/main%20screen/widgets/information.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/custom_tab_view.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/phone_detail.dart';
import 'package:untitled/src/screens/search%20screen/widget/other_phone.dart';

import '../../../utils/app_constant/app_colors.dart';
import '../../providers/repository_provider.dart';
import '../../widget/search_appbar.dart';

class PhoneRatingScreen extends StatefulWidget {
  Phone phone;
  PhoneRatingScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<PhoneRatingScreen> createState() => _PhoneRatingScreenState();
}

class _PhoneRatingScreenState extends State<PhoneRatingScreen> {
  bool isSearching = false;
  late RepositoryProvider provider;
  Widget title() {
    return isSearching
        ? SearchAppBar(listPhone: provider.phones)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset('assets/logo.png'),
          );
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<RepositoryProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.Blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: AppColors.White,
          centerTitle: true,
          title: title(),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: GestureDetector(
                child: !isSearching
                    ? SvgPicture.asset('assets/search.svg')
                    : const Icon(
                        Icons.cancel,
                        color: AppColors.LightBlue,
                      ),
                onTap: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              // Padding(
              //   child: Image.asset('assets/advertisement.png'),
              //   padding: const EdgeInsets.only(top: 8, bottom: 18),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhoneDetail(phone: widget.phone),
              ),
              CustomTabView(phone: widget.phone),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: OtherPhone(),
              ),
              const SizedBox(
                height: 18,
              ),
              const Information(),
            ],
          ),
        ),
      ),
    );
  }
}
