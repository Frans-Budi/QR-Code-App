import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code/app/modules/loading/loading_screen.dart';
import 'package:qr_code/models/user_model.dart';
import 'package:qr_code/providers/auth_provider.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(
    MyApp(),
  );

  // Get.put(AuthController(), permanent: true);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthProvider authProvider = Get.put(AuthProvider(), permanent: true);
  final box = GetStorage();

  Stream<UserModel> autoLogin() async* {
    if (box.read('token') != null) {
      String token = box.read('token');
      if (await authProvider.loginWithToken(token)) {
        yield authProvider.user!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: autoLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }
          // print(snapshot.data!.email);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "QR Code",
            initialRoute: snapshot.hasData ? Routes.home : Routes.login,
            getPages: AppPages.routes,
          );
        });
  }
}
