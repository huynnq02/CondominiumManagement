import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/bill/billAPI_repository.dart';

class BillAPIProvider extends BaseProvider<BillAPIRepository> {
  @override
  BillAPIRepository initRepository() {
    return BillAPIRepository();
  }

  Future getAllApartmentBillAPIProvider() async {
    final res = await repository.getAllAparmentBilllAPIRepository();
    // print("kq ne:");
    // print(res.data['result']['items']);
    print("info");
    print(res.data);
    return res.data['result']['items'];
  }

  Future getAllServiceBillAPIProvider() async {
    final res = await repository.getAllServiceBillAPIRepository();
    // print("kq ne:");
    // print(res.data['result']['items']);
    return res.data['result']['items'];
  }
}
