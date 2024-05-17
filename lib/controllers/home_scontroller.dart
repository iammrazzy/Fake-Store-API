import 'package:fake_store/views/cart_screen.dart';
import 'package:fake_store/views/product_screen.dart';
import 'package:fake_store/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  // index
  int defaultIndex = 0;

  void selctedIndex(int newIndex){
    defaultIndex = newIndex;
    update();
  }

  // screen
  List<Widget> screens = [
    ProductScreen(),
    SearchScreen(),
    CartScreen(),
  ];
}