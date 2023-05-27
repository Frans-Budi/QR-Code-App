import 'package:get/get.dart';
import 'package:qr_code/providers/product_provider.dart';

import '../controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(
      () => ProductsController(),
    );
    Get.lazyPut<ProductProvider>(
      () => ProductProvider(),
    );
  }
}
