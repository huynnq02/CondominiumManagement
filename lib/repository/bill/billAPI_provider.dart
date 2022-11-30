import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/bill/bill_repository.dart';

class BillAPIProvider extends BaseProvider<BillRepository> {
  @override
  BillRepository initRepository() {
    return BillRepository();
  }

  Future getAllEAndWAPIRepository() async {
    final res = await repository.getAllEAndWBillAPIRepository();
    // print("kq ne:");
    // print(res.data['result']['items']);
    return res.data['result']['items'];
  }
  Future getAllServiceBillAPIRepository() async {
    final res = await repository.getAllServiceBillAPIRepository();
    // print("kq ne:");
    // print(res.data['result']['items']);
    return res.data['result']['items'];
  }
}
