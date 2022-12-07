import 'package:untitled/repository/apartment/apartmentAPI_repository.dart';
import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/bill/billAPI_repository.dart';

class BillAPIProvider extends BaseProvider<BillAPIRepository> {
  @override
  BillAPIRepository initRepository() {
    return BillAPIRepository();
  }

  Future getBillId() async {
    final res = await repository.getBill();
    return res.data['result'];
  }
}
