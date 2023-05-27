import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../models/product_model.dart';
import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({Key? key}) : super(key: key);

  final ProductModel product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.codeC.text = product.code!;
    controller.nameC.text = product.name!;
    controller.qtyC.text = "${product.quantity}";
    controller.id = "${product.id}";
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailProductView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImage(
                  data: "${product.code}",
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Product code
          TextField(
            autocorrect: false,
            controller: controller.codeC,
            keyboardType: TextInputType.number,
            readOnly: true,
            maxLength: 10,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: "Product Code",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
            ),
          ),
          const SizedBox(height: 20),
          // Product name
          TextField(
            autocorrect: false,
            controller: controller.nameC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Product Name",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
            ),
          ),
          const SizedBox(height: 20),
          // Product name
          TextField(
            autocorrect: false,
            controller: controller.qtyC,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: "Quantity",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
            ),
          ),
          const SizedBox(height: 35),
          // Button Update
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                await controller.editProduct();
              }
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                padding: const EdgeInsets.symmetric(vertical: 16)),
            child: Obx(
              () => Text(
                  controller.isLoading.isFalse ? "Update Product" : "Loading"),
            ),
          ),
          // Button Delete
          TextButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Delete Product?",
                middleText: "Are you sure to delete this product?",
                actions: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoadingDelete.isFalse) {
                        await controller.deleteProduct();
                      }
                    },
                    child: Obx(
                      () => controller.isLoadingDelete.isFalse
                          ? const Text("Delete")
                          : Container(
                              padding: const EdgeInsets.all(2),
                              width: 15,
                              height: 15,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            ),
                    ),
                  )
                ],
              );
            },
            child: Text(
              "Delete Product",
              style: TextStyle(color: Colors.red.shade900),
            ),
          ),
        ],
      ),
    );
  }
}
