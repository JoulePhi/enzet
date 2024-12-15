import 'package:enzet/app/data/middlewares/guest_middleware.dart';
import 'package:get/get.dart';

import '../data/middlewares/auth_middleware.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/insert/bindings/insert_binding.dart';
import '../modules/insert/views/insert_view.dart';
import '../modules/lists/bindings/lists_binding.dart';
import '../modules/lists/views/lists_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/views/products_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/stores/bindings/stores_binding.dart';
import '../modules/stores/views/stores_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.STORES;
  static const AUTHENTICATED = Routes.STORES;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.INSERT,
      page: () => const InsertView(),
      binding: InsertBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.LISTS,
      page: () => const ListsView(),
      binding: ListsBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.STORES,
      page: () => const StoresView(),
      binding: StoresBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
