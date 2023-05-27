import 'package:qr_code/models/product_model.dart';
import 'package:qr_code/services/product_service.dart';

class ProductProvider {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ProductModel? _product;
  ProductModel? get product => _product;

  String? _message;
  String? get message => _message;

  Future<bool> getProduct() async {
    try {
      List<ProductModel>? products = await ProductService().getProduct();
      _products = products!;

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addProduct({
    String? code,
    String? name,
    String? quantity,
  }) async {
    try {
      ProductModel product = await ProductService().addProduct(
        code: code,
        name: name,
        quantity: int.parse(quantity!),
      );

      _product = product;
      return true;
    } catch (e) {
      String message = await ProductService().addProduct(
        code: code,
        name: name,
        quantity: int.parse(quantity!),
      );

      _message = message;

      return false;
    }
  }

  Future<bool> editProduct({
    String? code,
    String? name,
    String? quantity,
    String? id,
  }) async {
    try {
      ProductModel product = await ProductService().editProduct(
        code: code,
        name: name,
        quantity: int.parse(quantity!),
        id: id,
      );

      _product = product;
      return true;
    } catch (e) {
      String message = await ProductService().editProduct(
        code: code,
        name: name,
        quantity: int.parse(quantity!),
        id: id,
      );

      _message = message;

      return false;
    }
  }

  Future<bool> deleteProduct({
    String? id,
  }) async {
    try {
      ProductModel product = await ProductService().deleteProduct(
        id: id,
      );

      _product = product;
      return true;
    } catch (e) {
      String message = await ProductService().deleteProduct(
        id: id,
      );

      _message = message;

      return false;
    }
  }

  Future<bool> getProductByCode({
    String? code,
  }) async {
    try {
      ProductModel product =
          await ProductService().getProductByCode(code: code);

      _product = product;
      return true;
    } catch (e) {
      String message = await ProductService().getProductByCode(code: code);

      _message = message;

      return false;
    }
  }
}
