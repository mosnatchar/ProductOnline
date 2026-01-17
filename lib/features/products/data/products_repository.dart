import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import 'product_model.dart';

class ProductsRepository {
  final Dio _dio;

  ProductsRepository({Dio? dio}) : _dio = dio ?? DioClient.create();

  Future<List<Product>> fetchProducts() async {
    final res = await _dio.get('/products');
    final data = res.data as Map<String, dynamic>;
    final list = (data['products'] as List).cast<Map<String, dynamic>>();
    return list.map(Product.fromJson).toList();
  }
}
