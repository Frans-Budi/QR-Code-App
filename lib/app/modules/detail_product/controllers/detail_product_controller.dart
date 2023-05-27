import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code/providers/product_provider.dart';

class DetailProductController extends GetxController {
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  ProductProvider productProvider = Get.find();

  String? id;

  RxBool isLoading = false.obs;
  RxBool isLoadingDelete = false.obs;

  Future<void> editProduct() async {
    if (codeC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        qtyC.text.isNotEmpty) {
      isLoading(true);
      if (await productProvider.editProduct(
        code: codeC.text,
        name: nameC.text,
        quantity: qtyC.text,
        id: id,
      )) {
        Get.snackbar("Berhasil", "Data Berhasil diubah!",
            duration: const Duration(seconds: 2));
      } else {
        Get.snackbar("Terjadi Kesalahan", "${productProvider.message}");
      }
      isLoading(false);
    } else {
      Get.snackbar("Terjadi Kesalahan", "Semua data harus diisi!");
    }
  }

  Future<void> deleteProduct() async {
    isLoadingDelete(true);
    if (await productProvider.deleteProduct(
      id: id,
    )) {
      Get.back();
      Get.back();
      Get.snackbar("Berhasil", "Data Berhasil dihapus!",
          duration: const Duration(seconds: 2));
    } else {
      Get.back();
      Get.snackbar("Terjadi Kesalahan", "${productProvider.message}");
    }
    isLoadingDelete(false);
  }
}
