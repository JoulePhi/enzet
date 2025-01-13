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
        // final isFirstRouteInCurrentTab = !await controller
        //     .navigatorKeys[controller.selectedIndex].currentState!
        //     .maybePop();

        // if (isFirstRouteInCurrentTab) {
        //   if (controller.selectedIndex != 0) {
        //     controller.changePage(0);
        //   }
        // }
      },
      child: Scaffold(
        body: Row(
          children: [
            if (GetPlatform.isWeb)
              Obx(() => CollapsibleSidebar(
                    isCollapsed: controller.isSidebarCollapsed,
                    onToggle: controller.toggleSidebar,
                    selectedIndex: controller.selectedIndex,
                    onItemSelected: controller.changePage,
                  )),
            Expanded(
              child: Navigator(
                key: Get.nestedKey(1),
                initialRoute: Routes.HOME,
                onGenerateRoute: (settings) {
                  if (kDebugMode) {
                    print('Page name: ${settings.name}');
                  }
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
            ),
          ],
        ),
        floatingActionButton: Obx(
          () => controller.selectedIndex != 2
              ? FloatingActionButton(
                  backgroundColor: AppStyle.robinsEggBlue,
                  onPressed: () {
                    Get.toNamed(Routes.INVOICE);
                  },
                  child: const Icon(Icons.print, color: Colors.white),
                )
              : const SizedBox.shrink(),
        ),
        bottomNavigationBar: GetPlatform.isAndroid
            ? SalomonBottomBar(
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
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.person),
                    title: const Text("Profile"),
                    selectedColor: Colors.teal,
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class CollapsibleSidebar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onToggle;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CollapsibleSidebar({
    Key? key,
    required this.isCollapsed,
    required this.onToggle,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isCollapsed ? 70 : 250,
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: isCollapsed
                  ? IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: onToggle,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 50,
                        ),
                        Text(
                          'Enzet',
                          style: AppStyle.textBlack.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: onToggle,
                        ),
                      ],
                    ),
            ),
            _buildNavItem(
              icon: Icons.home,
              title: 'Home',
              index: 0,
              color: Colors.purple,
            ),
            _buildNavItem(
              icon: Icons.view_list_rounded,
              title: 'Products',
              index: 1,
              color: Colors.pink,
            ),
            _buildNavItem(
              icon: Icons.add,
              title: 'Insert',
              index: 2,
              color: Colors.blueAccent,
            ),
            _buildNavItem(
              icon: Icons.person,
              title: 'Profile',
              index: 3,
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required int index,
    required Color color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: selectedIndex == index ? color : Colors.grey,
      ),
      title: isCollapsed
          ? null
          : Text(
              title,
              style: TextStyle(
                color: selectedIndex == index ? color : Colors.grey,
              ),
            ),
      selected: selectedIndex == index,
      onTap: () => onItemSelected(index),
    );
  }
}
