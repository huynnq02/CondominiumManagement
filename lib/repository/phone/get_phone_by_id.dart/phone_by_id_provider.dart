import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/phone/get_phone_by_id.dart/phone_by_id_repository.dart';
import 'package:untitled/src/models/phone.dart';

class PhoneByIdProvider extends BaseProvider<PhoneByIdRepository> {
  @override
  PhoneByIdRepository initRepository() {
    return PhoneByIdRepository();
  }

  Future<Phone> get(String idProduct) async {
    final res = await repository.phones(idProduct);

    return Phone.fromMap(res.data['result']);
  }
}
