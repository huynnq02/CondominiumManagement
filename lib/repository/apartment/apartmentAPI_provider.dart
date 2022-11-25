import 'package:untitled/repository/apartment/apartmentAPI_repository.dart';
import 'package:untitled/repository/base/base_provider.dart';

class ApartmentAPIProvider extends BaseProvider<ApartmentAPIRepository> {
  @override
  ApartmentAPIRepository initRepository() {
    return ApartmentAPIRepository();
  }

  Future getAllApartments() async {
    final res = await repository.getAllApartments();
    return res.data['result'];
  }
}
