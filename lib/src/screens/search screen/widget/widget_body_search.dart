import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/filter_provider.dart';
import 'package:untitled/src/providers/search_paginatior_provider.dart';
import 'package:untitled/src/screens/search%20screen/widget/search_item.dart';
import '../../../../utils/app_constant/app_text_style.dart';
import '../../../models/phone.dart';
import '../../../providers/repository_provider.dart';
import '../../main screen/widgets/information.dart';
import 'other_phone.dart';
import 'paginator.dart';

class WidgetBodySearch extends StatefulWidget {
  List<Phone> listResultPhone;
  WidgetBodySearch({Key? key, required this.listResultPhone}) : super(key: key);

  @override
  State<WidgetBodySearch> createState() => _WidgetBodySearchState();
}

class _WidgetBodySearchState extends State<WidgetBodySearch> {
  SearchPaginatorProvider? providerSearch;
  FilterProvider? filterProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filterProvider = Provider.of<FilterProvider>(context, listen: true);
    providerSearch =
        Provider.of<SearchPaginatorProvider>(context, listen: true);
    // lấy danh sách sau khi lọc
    filterProvider!.filterPhone(widget.listResultPhone);
    providerSearch!.fetchPhone(widget.listResultPhone);

    return SingleChildScrollView(
      child: FutureBuilder(
        future: providerSearch!.fetchPhone(filterProvider!.listPhone),
        builder: (context, snapshot) {
          // check trạng thái số trang nếu nhỏ hơn số lượng sản phẩm thì mặc định là 1
          providerSearch!.state > providerSearch!.listSortPhone.length
              ? providerSearch!.state = 1
              : providerSearch!.state;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    // Padding(
                    //   child: Image.asset('assets/advertisement.png'),
                    //   padding: const EdgeInsets.only(top: 8, bottom: 18),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        'Khoảng ${filterProvider!.listPhone.length} kết quả',
                        style: AppTextStyle.nunitoSize13.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return SearchedItem(
                          phone: providerSearch!
                              .listSortPhone[providerSearch!.state - 1],
                        );
                      },
                    ),
                    Paginator(providerSearch!.state,
                        providerSearch!.listSortPhone.length),
                    const SizedBox(
                      height: 30,
                    ),
                    const OtherPhone(),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Information(),
              const SizedBox(
                height: 25,
              ),
            ],
          );
        },
      ),
    );
  }
}
