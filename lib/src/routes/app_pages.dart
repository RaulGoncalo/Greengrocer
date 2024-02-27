import 'package:get/get.dart';
import 'package:quitanda/src/pages/auth/screens/sign_in_screen.dart';
import 'package:quitanda/src/pages/auth/screens/sign_up_screen.dart';
import 'package:quitanda/src/pages/base/cart/binding/cart_binding.dart';
import 'package:quitanda/src/pages/base/orders/binding/orders_binding.dart';
import 'package:quitanda/src/pages/base/screen/base_screen.dart';
import 'package:quitanda/src/pages/base/binding/navigation_binding.dart';
import 'package:quitanda/src/pages/base/home/binding/home_binding.dart';
import 'package:quitanda/src/pages/product/screens/product_screen.dart';
import 'package:quitanda/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => ProductScreen(),
      name: PagesRoutes.productRoute,
    ),
    GetPage(
      page: () => const SplashScreen(),
      name: PagesRoutes.splashRoute,
    ),
    GetPage(
      page: () => SignInScreen(),
      name: PagesRoutes.signInRoute,
    ),
    GetPage(
      page: () => const SignUpScreen(),
      name: PagesRoutes.signUpRoute,
    ),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
        OrdersBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String productRoute = "/product";
  static const String splashRoute = "/splash";
  static const String signInRoute = "/signin";
  static const String signUpRoute = "/signup";
  static const String baseRoute = "/";
}
