import 'package:untitled/repository/auth/authAPI_repository.dart';
import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/src/models/user.dart';

class AuthAPIProvider extends BaseProvider<AuthAPIRepository> {
  @override
  AuthAPIRepository initRepository() {
    return AuthAPIRepository();
  }

  Future login({
    required String id,
    required String password,
  }) async {
    final res = await repository.login(
      id: id,
      password: password,
    );
    return res.data;
  }

  Future register({MDUser? mdUser}) async {
    final res = await repository.register(mdUser: mdUser);
    print(res.data);
    return res.data['success'];
  }
}
