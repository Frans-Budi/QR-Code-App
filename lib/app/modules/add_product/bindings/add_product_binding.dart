import 'package:get/get.dart';
import 'package:qr_code/providers/product_provider.dart';

import '../controllers/add_product_controller.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProductController>(
      () => AddProductController(),
    );
    Get.lazyPut<ProductProvider>(
      () => ProductProvider(),
    );
  }
}
