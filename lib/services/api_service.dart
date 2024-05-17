import 'package:dio/dio.dart';
import 'package:fake_store/models/product_model.dart';

class APIService {
  final Dio _dio = Dio();
  final String _baseURL = 'https://fakestoreapi.com';

  // Get all products
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await _dio.get('$_baseURL/products');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<ProductModel> products = data.map((json) => ProductModel.fromJson(json)).toList();
        print('Product data: 👉$data');
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load products');
    }
  }

  /*
  // Get product categories
  Future<List<String>> fetchCategories() async {
    try {
      final response = await _dio.get('$_baseURL/products/categories');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<String> categories = data.map((category) => category as String).toList();
        print('Categories: 👉$data');
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load categories');
    }
  }
  */
}
