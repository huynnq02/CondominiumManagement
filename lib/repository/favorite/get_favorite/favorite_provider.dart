import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/src/models/favorite.dart';

import 'favorite_reponsitory.dart';

class GetFavProvider extends BaseProvider<FavoriteReponsitory> {
  @override
  FavoriteReponsitory initRepository() {
    return FavoriteReponsitory();
  }

  Future<List<Favorite>> getFav() async {
    final res = await repository.getFavorite();
    return (res.data['result']['items'] as List)
        .map((e) => Favorite.fromMap(e))
        .toList();
  }
}
