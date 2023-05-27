import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTER'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Input Name
          TextField(
            autocorrect: false,
            controller: controller.nameC,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Name",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
            ),
          ),
          const SizedBox(height: 20),
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
            onPressed: () {
              controller.handleRegister();
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                padding: const EdgeInsets.symmetric(vertical: 16)),
            child: const Text("Register"),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sudah punya akun?"),
              TextButton(
                onPressed: () {
                  Get.offNamed(Routes.login);
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
