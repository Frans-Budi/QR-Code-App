import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:qr_code/models/user_model.dart';
import 'package:qr_code/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = AppConstants.baseUrl;
  final box = GetStorage();

  Future<dynamic> register({
    String? name,
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/register';
    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ${data['token']}';

      // Simpan Token ke Local Storage
      box.write("token", "${user.token}");

      return user;
    } else {
      String message = jsonDecode(response.body)['message'];
      return message;
      // throw Exception(message);
    }
  }

  Future<dynamic> login({
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/login';
    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ${data['token']}';

      // Simpan Token ke Local Storage
      box.write("token", "${user.token}");

      return user;
    } else {
      String message = jsonDecode(response.body)['message'];
      return message;
    }
  }

  Future<dynamic> loginWithToken(String token) async {
    var url = '$baseUrl/login_with_token';

    print(token);

    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: header,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      user.token = 'Bearer ${data['token']}';

      return user;
    } else {
      String message = jsonDecode(response.body)['message'];
      return message;
    }
  }

  Future<dynamic> logout(String token) async {
    var url = '$baseUrl/logout';

    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      // Hapus Token dari Local Storage
      box.remove("token");

      return data;
    } else {
      String message = jsonDecode(response.body)['message'];
      return message;
    }
  }
}
