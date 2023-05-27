import 'package:qr_code/models/user_model.dart';
import 'package:qr_code/services/auth_service.dart';

class AuthProvider {
  UserModel? _user;
  UserModel? get user => _user;
  set setUser(UserModel user) {
    _user = user;
  }

  String? _message;
  String? get message => _message;

  Future<bool> register({
    String? name,
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        email: email,
        password: password,
      );

      // print(message);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      _message = await AuthService().register(
        name: name,
        email: email,
        password: password,
      );
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;

      return true;
    } catch (e) {
      _message = await AuthService().login(
        email: email,
        password: password,
      );
      return false;
    }
  }

  Future<bool> loginWithToken(String token) async {
    try {
      UserModel user = await AuthService().loginWithToken(token);

      _user = user;

      return true;
    } catch (e) {
      _message = await AuthService().loginWithToken(token);
      return false;
    }
  }

  Future<bool> logout(String token) async {
    try {
      await AuthService().logout(token);

      return true;
    } catch (e) {
      _message = await AuthService().logout(token);
      return false;
    }
  }
}
