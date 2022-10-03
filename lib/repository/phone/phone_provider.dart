import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/phone/phone_repository.dart';
import 'package:untitled/src/models/phone.dart';

class PhoneProvider extends BaseProvider<PhoneRepository> {
  @override
  PhoneRepository initRepository() {
    return PhoneRepository();
  }

  Future<List<Phone>> get() async {
    final res = await repository.phones();
    return (res.data['result'] as List).map((e) => Phone.fromMap(e)).toList();
  }
}
