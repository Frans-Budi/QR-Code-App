import 'dart:convert';
import 'dart:ffi';

import 'package:get_storage/get_storage.dart';
import 'package:qr_code/models/product_model.dart';
import 'package:http/http.dart' as http;

import '../utils/app_constants.dart';

class ProductService {
  String baseUrl = AppConstants.baseUrl;
  final box = GetStorage();

  Future<List<ProductModel>?> getProduct() async {
    String token = box.read('token');
    var url = '$baseUrl/products';
    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ProductModel> products = [];

      // print(data);
      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }
      return products;
    }
  }

  Future<dynamic> addProduct({
    String? code,
    String? name,
    int? quantity,
  }) async {
    String token = box.read('token');
    var url = '$baseUrl/products';
    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'code': code,
      'name': name,
      'quantity': quantity,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ProductModel product = ProductModel.fromJson(data);

      return product;
    } else {
      String message = jsonDecode(response.body)['message'];
      return message;
    }
  }

  Future<dynamic> editProduct({
    String? code,
    String? name,
    int? quantity,
    String? id,
  }) async {
    String token = box.read('token');
    var url = '$baseUrl/products/$id';
    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'code': code,
      'name': name,
      'quantity': quantity,
    });
    var response = await http.put(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ProductModel product = ProductModel.fromJson(data);

      return product;
    } else {
      String message = jsonDecode(response.body)['message'];
      return message;
    }
  }

  Future<dynamic> deleteProduct({
    String? id,
  }) async {
    String token = box.read('token');
    var url = '$baseUrl/products/$id';
    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.delete(
      Uri.parse(url),
      headers: header,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ProductModel product = ProductModel.fromJson(data);

      return product;
    } else {
      String message = jsonDecode(response.body)['message'];
      return message;
    }
  }

  Future<dynamic> getProductByCode({
    String? code,
  }) async {
    String token = box.read('token');
    var url = '$baseUrl/products/$code';
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
      ProductModel product = ProductModel.fromJson(data);

      return product;
    } else {
      String message = jsonDecode(response.body)['message'];
      return message;
    }
  }
}
