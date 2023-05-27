import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Input Email
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
            ),
          ),
          const SizedBox(height: 20),
          // Input Password
          Obx(
            () => TextField(
              autocorrect: false,
              controller: controller.passC,
              keyboardType: TextInputType.text,
              obscureText: controller.isHidden.value,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isHidden.toggle();
                  },
                  icon: Icon(controller.isHidden.isFalse
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
              ),
            ),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                controller.isLoading(true);
                await controller.handleLogin();
                controller.isLoading(false);
              }
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                padding: const EdgeInsets.symmetric(vertical: 16)),
            child: Obx(
              () => Text(controller.isLoading.isFalse ? "Login" : "Loading"),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Belum punya akun?"),
              TextButton(
                onPressed: () {
                  Get.offNamed(Routes.register);
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
