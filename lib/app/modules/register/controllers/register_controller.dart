import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code/app/routes/app_pages.dart';
import 'package:qr_code/providers/auth_provider.dart';

class RegisterController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxBool isHidden = true.obs;

  final authProvider = Get.find<AuthProvider>();

  Future<void> handleRegister() async {
    if (await authProvider.register(
      name: nameC.text,
      email: emailC.text,
      password: passC.text,
    )) {
      Get.offNamed(Routes.home);
    } else {
      Get.snackbar("Terjadi Kesalahan", "${authProvider.message}");
    }
  }
}
