import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../models/product_model.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRODUCTS'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ProductModel>>(
          stream: controller.streamProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Products"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                ProductModel product = snapshot.data![index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Material(
                    // color: Colors.grey.shade300,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.detailProduct, arguments: product);
                      },
                      child: Container(
                        // height: 100,
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product.code}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text("${product.name}"),
                                  Text("Jumlah: ${product.quantity}"),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: QrImage(
                                data: "${product.code}",
                                size: 200,
                                version: QrVersions.auto,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
