import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_code/models/product_model.dart';
import 'package:qr_code/providers/product_provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../../providers/auth_provider.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  final authProvider = Get.find<AuthProvider>();
  final box = GetStorage();
  final productProvider = Get.put(ProductProvider());

  RxList<ProductModel> allProducts = List<ProductModel>.empty().obs;

  Future<void> logout() async {
    String token = box.read('token');
    if (await authProvider.logout(token)) {
      Get.offNamed(Routes.login);
    } else {
      Get.snackbar("Terjadi Kesalahan", "${authProvider.message}");
    }
  }

  Future<void> downloadCatalog() async {
    final pdf = pw.Document();

    final font = await rootBundle.load("assets/fonts/Nunito-Regular.ttf");
    final regular = pw.Font.ttf(font);

    final font2 = await rootBundle.load("assets/fonts/Nunito-Bold.ttf");
    final bold = pw.Font.ttf(font2);

    // Reset all products -> untuk mengatasi duplikasi
    allProducts([]);
    // Isi data allProducts dari database
    if (await productProvider.getProduct()) {
      for (var element in productProvider.products) {
        allProducts.add(element);
      }
    }

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            List<pw.TableRow> allData = List.generate(
              allProducts.length,
              (index) {
                ProductModel product = allProducts[index];
                return pw.TableRow(
                  children: [
                    // No
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        "${index + 1}",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 10, font: regular),
                      ),
                    ),
                    // Kode Barang,
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        product.code!,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 10, font: regular),
                      ),
                    ),
                    // Nama Barang,
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        product.name!,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 10, font: regular),
                      ),
                    ),
                    // Qty
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        "${product.quantity!}",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 10, font: regular),
                      ),
                    ),
                    // QR Code
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.BarcodeWidget(
                        color: PdfColor.fromHex("#000000"),
                        barcode: pw.Barcode.qrCode(),
                        data: product.code!,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                );
              },
            );

            return [
              pw.Center(
                child: pw.Text(
                  "Catalog Products",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 24, font: bold),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColor.fromHex("#000000"),
                  width: 2,
                ),
                children: [
                  pw.TableRow(
                    children: [
                      // No
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          "No",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: 10, font: bold),
                        ),
                      ),
                      // Kode Barang,
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          "Product Code",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: 10, font: bold),
                        ),
                      ),
                      // Nama Barang,
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          "Product Name",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: 10, font: bold),
                        ),
                      ),
                      // Qty
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          "Quantity",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: 10, font: bold),
                        ),
                      ),
                      // QR Code
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          "QR Code",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: 10, font: bold),
                        ),
                      ),
                    ],
                  ),
                  // Isi Data nya
                  ...allData,
                ],
              ),
            ];
          }),
    );

    // Simpan
    Uint8List bytes = await pdf.save();

    // Buat file kosong di directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mydocument.pdf');

    //Memasukkan data bytes -> file kosong
    await file.writeAsBytes(bytes);

    // Open pdf
    await OpenFile.open(file.path);
  }

  Future<void> getProductByCode() async {
    // Scan QR Code
    String barcode = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Cancel", true, ScanMode.QR);

    // Get data dari api search by product id
    if (await productProvider.getProductByCode(code: barcode)) {
      ProductModel product = productProvider.product!;
      Get.toNamed(Routes.detailProduct, arguments: product);
    } else {
      String message = productProvider.message!;
      Get.snackbar("Terjadi Kesalahan", message);
    }
  }
}
