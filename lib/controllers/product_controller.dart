import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fake_store/models/product_model.dart';
import 'package:fake_store/services/api_service.dart';
import 'package:fake_store/views/home.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  final APIService _apiService = APIService();
  final searchController = TextEditingController();
  List<ProductModel> productList = [];
  List<String> categoryList = [];
  List<ProductModel> searchedList = [];
  List<ProductModel> cartList = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getAllProduct();
  }


  // get all product 
  Future<void> getAllProduct() async {
    try {
      isLoading = true;
      update();
      productList = await _apiService.fetchProducts();
      update();
    } catch (e) {
      print('Error: 👉 $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  /*
  // get all categories
  Future<void> getAllCategories() async {
    try {
      isLoading = true;
      update();
      categoryList = await _apiService.fetchCategories();
      update();
    } catch (e) {
      print('Error: 👉 $e');
    } finally {
      isLoading = false;
      update();
    }
  }
  */

  // search product by title price category & description
  void searchProduct(String query){
    searchedList.assignAll(
      productList.where((pro){
          final proTitle = pro.title?.toLowerCase() ?? '';
          final proPrice = pro.price?.toString() ?? '';
          final proDescription = pro.description?.toLowerCase() ?? '';
          final proCategory = pro.category?.toLowerCase() ?? '';
          return proTitle.contains(query.toLowerCase()) || proPrice.contains(query.toLowerCase())
          || proDescription.contains(query.toLowerCase()) || proCategory.contains(query.toLowerCase());
        }
      ).toList(),
    );
    update();
  }

  // toggle love button
  bool toggleLove(int id) {
    final productItemIndex = productList.indexWhere((pro) => pro.id == id);
    if (productItemIndex != -1) {
      productList[productItemIndex].isLoved = !productList[productItemIndex].isLoved;
      update();
      return true;
    } else {
      print('Product item with id $id not found.');
      return false;
    }
  }

  // toggle add to cart
  void toggleCart(ProductModel pro) {
    final index = cartList.indexWhere((pro) => pro.id == pro.id);
    if (index != -1) {
      deleteCart(pro.id!);
    } else {
      addToCart(pro);
    }
  }

  // increase QTY by each item
  void increaseQty(int id) {
    final productItemIndex = productList.indexWhere((pro) => pro.id == id);
    if (productItemIndex != -1) {
      productList[productItemIndex].qty++;
      update();
    }
  }

  // decrease QTY by each item
  void decreaseQty(int id) {
    final productItemIndex = productList.indexWhere((pro) => pro.id == id);
    if (productItemIndex != -1 && productList[productItemIndex].qty > 1) {
      productList[productItemIndex].qty--;
      update();
    }
  }

  // get total QTY by each item
  int totalEachItemQty(int id) {
    final productItemIndex = productList.indexWhere((item) => item.id == id);
    return productItemIndex != -1 ? productList[productItemIndex].qty : 0;
  }

  // get total Price by each item
  double totalEachItemPrice(int id) {
    final productItemIndex = productList.indexWhere((item) => item.id == id);
    if (productItemIndex != -1) {
      final productItem = productList[productItemIndex];
      return productItem.price! * productItem.qty;
    }
    return 0.0;
  }

  // get all total QTY
  int allTotalQty() {
    int totalQty = 0;
    for (var productItem in cartList) {
      totalQty += productItem.qty;
    }
    return totalQty;
  }

  // get all total price
  double allTotalPriceUSA() {
    double totalPrice = 0.0;
    for (var productItem in cartList) {
      totalPrice += productItem.price! * productItem.qty;
    }
    return totalPrice;
  }


  // add to cart
  void addToCart(ProductModel pro) {
    if (!cartList.contains(pro)) {
      pro.isInCart = true;
      cartList.add(pro);
      showMessage('Added to cart!', Colors.indigo);
      update();
    }
  }

  // remove from cart
  void deleteCart(int id) {
    final index = cartList.indexWhere((pro) => pro.id == id);
    if (index != -1) {
      cartList[index].qty = 1;
      cartList[index].isLoved = false;
      cartList[index].isInCart = false;
      cartList.removeAt(index);
      update();
    }
  }

  // check out
  void paymentProduct() {
    try {
      resetDataAfterCheckout();
      showMessage('Payment successful!', Colors.indigo);
      Get.offAll(Home());
    } catch (e) {
      print('Error during checkout: $e');
      showMessage('Error during checkout: $e', Colors.red);
    } finally {
      cartList.clear();
      update();
    }
  }

  // reset data
  void resetDataAfterCheckout() {
    for (var coffeeItem in cartList) {
      coffeeItem.qty = 1;
      coffeeItem.isLoved = false;
      coffeeItem.isInCart = false;
    }
    update();
  }

  // save image from the API ( Internet source )
  void saveImage(String imageUrl) async {
    try {
      isLoading = true;
      update();
      String name = DateTime.now().toString();
      final response = await Dio().get(
        imageUrl,
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(minutes: 1),
          validateStatus: (status) => status! < 500,
        ),
      );

      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: 'Fake-Store/$name',
      );

      Get.back();
      print('Result: 👉 $result');
      showMessage('Image saved success!', Colors.indigo);
    } catch (e) {
      print('Error saving image: $e');
      showMessage('Error saving image: $e', Colors.red);
    } finally {
      isLoading = false;
      update();
    }
  }

  // show message
  void showMessage(String msg, Color color) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
