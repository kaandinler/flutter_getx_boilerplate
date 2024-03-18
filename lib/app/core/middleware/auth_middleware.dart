import 'package:flutter/material.dart';

import 'package:get/get.dart';

//Created by https://github.com/kaandinler

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  //INFO This function will be called when the page of the called route is being searched for. It takes RouteSettings as a result to redirect to. Or give it null and there will be no redirecting.
  @override
  RouteSettings? redirect(String? route) {
    // Kullanıcının yetkili olup olmadığını kontrol et
    bool userIsAuthenticated = checkUserAuthentication();

    if (!userIsAuthenticated) {
      // Kullanıcı yetkili değilse, giriş sayfasına yönlendir
      return const RouteSettings(name: '/login');
    }

    // Kullanıcı yetkiliyse, null dönerek mevcut rota işlemine devam et
    return null;
  }

  bool checkUserAuthentication() {
    // Burada, kullanıcının yetkili olup olmadığını kontrol eden mantığı yerleştirin
    // Bu örnekte, varsayılan olarak `true` döndürülmüştür.
    return true;
  }

  //INFO This function will be called when this Page is called before anything created you can use it to change something about the page or give it new page
  // @override
  // GetPage onPageCalled(GetPage page) {
  //   final authService = Get.find<AuthService>();
  //   return page.copyWith(title: 'Welcome ${authService.UserName}');
  // }

  //INFO This function will be called right after the Bindings are initialize. Here you can do something after that you created the bindings and before creating the page widget.
  // @override
  // GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
  //   return page;
  // }

  //INFO This function will be called right before the Bindings are initialize. Here you can change Bindings for this page.
  // @override
  // List<Bindings> onBindingsStart(List<Bindings> bindings) {
  //   final authService = Get.find<AuthService>();
  //   if (authService.isAdmin) {
  //     bindings.add(AdminBinding());
  //   }
  //   return bindings;
  // }
}
