import 'package:get/get.dart';
import 'package:qr_code/providers/product_provider.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductController>(
      () => DetailProductController(),
    );
    Get.lazyPut<ProductProvider>(
      () => ProductProvider(),
    );
  }
}
