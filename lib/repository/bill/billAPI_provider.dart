import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/bill/billAPI_repository.dart';
import 'package:untitled/src/models/apartment.dart';
import 'package:untitled/src/models/bill.dart';

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

  Future editApartmentBillAPIProvider(ApartmentBill aparmentBill) async {
    final res = await repository.editApartmentBillAPIRepository(aparmentBill);

    return res.data['success'];
  }

  Future editServiceBillAPIProvider(ServiceBill serviceBill) async {
    final res = await repository.editServiceBillAPIRepository(serviceBill);
    print("thong tin");
    print(res.data);
    return res.data['success'];
  }
}
