import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/favorite/delete_favorite/delete_favorite_repository.dart';

class DeleteFavProvider extends BaseProvider<DeleteFavoriteReponsitory> {
  @override
  DeleteFavoriteReponsitory initRepository() {
    return DeleteFavoriteReponsitory();
  }

  Future deleteFav({
    required List idProduct,
  }) async {
    final res = await repository.deleteFavorite(idProduct);
    return res.data;
  }
}
