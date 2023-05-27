import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../providers/auth_provider.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;

  final authProvider = Get.find<AuthProvider>();

  Future<void> handleLogin() async {
    if (await authProvider.login(
      email: emailC.text,
      password: passC.text,
    )) {
      Get.offNamed(Routes.home);
    } else {
      Get.snackbar("Terjadi Kesalahan", "${authProvider.message}");
    }
  }
}
