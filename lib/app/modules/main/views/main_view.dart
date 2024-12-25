import 'package:enzet/app/data/contollers/navigation_controller.dart';
import 'package:enzet/app/routes/app_pages.dart';
import 'package:enzet/theme/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainView extends GetView<NavigationController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool pop, dynamic p) async {
        final isFirstRouteInCurrentTab = !await controller
            .navigatorKeys[controller.selectedIndex].currentState!
            .maybePop();

        if (isFirstRouteInCurrentTab) {
          if (controller.selectedIndex != 0) {
            controller.changePage(0);
          }
        }
      },
      child: PopScope(
        onPopInvokedWithResult: (bool pop, dynamic p) async {
          final isFirstRouteInCurrentTab = !await controller
              .navigatorKeys[controller.selectedIndex].currentState!
              .maybePop();

          if (isFirstRouteInCurrentTab) {
            if (controller.selectedIndex != 0) {
              controller.changePage(0);
            }
          }
        },
        child: Scaffold(
          body: Navigator(
            key: Get.nestedKey(1),
            initialRoute: Routes.HOME,
            onGenerateRoute: (settings) {
              final page = AppPages.routes.firstWhere(
                (page) => page.name == settings.name,
                orElse: () => AppPages.routes.first,
              );
              return GetPageRoute(
                settings: settings,
                page: page.page,
                binding: page.binding,
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.INVOICE);
            },
            child: const Icon(Icons.print),
          ),
          bottomNavigationBar: Obx(
            () => SalomonBottomBar(
              currentIndex: controller.selectedIndex,
              onTap: controller.changePage,
              unselectedItemColor: AppStyle.black,
              items: [
                SalomonBottomBarItem(
                  icon: const Icon(Icons.home),
                  title: const Text("Home"),
                  selectedColor: Colors.purple,
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.view_list_rounded),
                  title: const Text("Products"),
                  selectedColor: Colors.pink,
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.add),
                  title: const Text("Insert"),
                  selectedColor: Colors.blueAccent,
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: const Icon(Icons.person),
                  title: const Text("Profile"),
                  selectedColor: Colors.teal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Navigator _buildPageNavigator(int index, String initialRoute) {
    return Navigator(
      key: controller.navigatorKeys[index],
      onGenerateRoute: (settings) {
        GetPage? page;
        if (kDebugMode) {
          print('Settings name: ${settings.name}');
        }
        if (settings.name == initialRoute) {
          if (kDebugMode) {
            print('initialRoute: $initialRoute');
          }
          page =
              AppPages.routes.firstWhere((page) => page.name == initialRoute);
        } else if (settings.name == '/') {
          page =
              AppPages.routes.firstWhere((page) => page.name == initialRoute);
        } else {
          // Find the nested route
          for (final route in AppPages.routes) {
            if (kDebugMode) {
              print('route: $route');
            }
            final childPage = route.children.firstWhereOrNull(
                (child) => child.name == settings.name?.split(route.name)[1]);
            if (childPage != null) {
              page = childPage;
              break;
            }
          }
        }
        if (kDebugMode) {
          print('Page: $page');
        }
        if (page != null) {
          return GetPageRoute(
            settings: settings,
            page: page.page,
            binding: page.binding,
          );
        }

        return GetPageRoute(
          page: () => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
      },
    );
  }
}
