import 'package:untitled/repository/base/base_provider.dart';

import 'post_favorite_reponsitory.dart';

class PostFavProvider extends BaseProvider<PostFavoriteReponsitory> {
  @override
  PostFavoriteReponsitory initRepository() {
    return PostFavoriteReponsitory();
  }

  Future insertFav({
    required String idProduct,
  }) async {
    final res = await repository.postFavorite(idProduct);

    return res;
  }
}
