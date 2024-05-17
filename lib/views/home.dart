import 'package:badges/badges.dart';
import 'package:fake_store/controllers/home_scontroller.dart';
import 'package:fake_store/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final _homeController = Get.put(HomeController());
  final _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          body: _homeController.screens[_homeController.defaultIndex],
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.all(
                GoogleFonts.kantumruyPro(
                  fontSize: 15.0,
                ),
              ),
            ),
            child: GetBuilder<ProductController>(
              builder: (_) {
              return NavigationBar(
                height: 60.0,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                selectedIndex: _homeController.defaultIndex,
                onDestinationSelected: (newIndex) {
                  _homeController.selctedIndex(newIndex);
                },
                destinations: [
                  // home
                  NavigationDestination(
                    icon: Icon(
                      Icons.home,
                      color: Theme.of(context).primaryColor,
                    ),
                    selectedIcon: Icon(
                      Icons.home,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: 'Home',
                  ),

                  // search
                  NavigationDestination(
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    selectedIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: 'Search',
                  ),

                  // videos
                  NavigationDestination(
                    icon: badges.Badge(
                      position: BadgePosition.topEnd(top: -15, end: -12),
                      showBadge: _productController.cartList.isEmpty ? false : true,
                      badgeContent: Text(
                        _productController.cartList.length.toString(),
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      badgeStyle: BadgeStyle(
                        shape: BadgeShape.circle,
                        badgeColor: Colors.pink,
                        padding: const EdgeInsets.all(5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    selectedIcon: badges.Badge(
                      position: BadgePosition.topEnd(top: -15, end: -12),
                      showBadge: _productController.cartList.isEmpty ? false : true,
                      badgeContent: Text(
                        _productController.cartList.length.toString(),
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      badgeStyle: BadgeStyle(
                        shape: BadgeShape.circle,
                        badgeColor: Colors.pink,
                        padding: const EdgeInsets.all(5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    label: 'Cart',
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
