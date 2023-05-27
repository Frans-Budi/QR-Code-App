import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddProductView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Product code
          TextField(
            autocorrect: false,
            controller: controller.codeC,
            keyboardType: TextInputType.number,
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
          // Button
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                await controller.addProduct();
              }
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                padding: const EdgeInsets.symmetric(vertical: 16)),
            child: Obx(
              () => Text(
                  controller.isLoading.isFalse ? "Add Product" : "Loading"),
            ),
          ),
        ],
      ),
    );
  }
}
