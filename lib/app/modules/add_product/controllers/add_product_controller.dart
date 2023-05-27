import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code/providers/product_provider.dart';

class AddProductController extends GetxController {
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> addProduct() async {
    ProductProvider productProvider = Get.find();

    if (codeC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        qtyC.text.isNotEmpty) {
      isLoading(true);
      if (await productProvider.addProduct(
          code: codeC.text, name: nameC.text, quantity: qtyC.text)) {
        Get.back();
        Get.snackbar("Berhasil", "Product berhasil ditambahkan");
      } else {
        String message = productProvider.message!;
        Get.snackbar("Terjadi kesalahan", message);
      }
      isLoading(false);
    } else {
      Get.snackbar("Terjadi kesalahan", "Semua Inputan harus diisi!");
    }
  }
}
