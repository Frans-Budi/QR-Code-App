import 'package:get/get.dart';
import 'package:qr_code/providers/product_provider.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ProductProvider>(
      () => ProductProvider(),
    );
  }
}
