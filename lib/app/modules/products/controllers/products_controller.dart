import 'package:get/get.dart';
import 'package:qr_code/providers/product_provider.dart';

import '../../../../models/product_model.dart';

class ProductsController extends GetxController {
  ProductProvider productProvider = Get.find();

  Stream<List<ProductModel>> streamProducts() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (await productProvider.getProduct()) {
        yield productProvider.products;
      }
    }
  }
}
