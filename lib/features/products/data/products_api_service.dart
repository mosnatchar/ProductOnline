import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';

class ProductsApiService {
  ProductsApiService({Dio? dio}) : _dio = dio ?? DioClient.create();

  final Dio _dio;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final res = await _dio.get('/products');

    final body = res.data;
    if (body is Map<String, dynamic>) {
      final products = body['products'];
      if (products is List) {
        return products
            .whereType<Map>()
            .map((e) => e.cast<String, dynamic>())
            .toList();
      }
    }

    // fallback เผื่อ API คืน list ตรง ๆ
    if (body is List) {
      return body
          .whereType<Map>()
          .map((e) => e.cast<String, dynamic>())
          .toList();
    }

    return <Map<String, dynamic>>[];
  }
}
