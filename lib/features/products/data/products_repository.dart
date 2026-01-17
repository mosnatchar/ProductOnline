import 'product_model.dart';
import 'products_api_service.dart';

class ProductsRepository {
  ProductsRepository({required ProductsApiService api}) : _api = api;

  final ProductsApiService _api;

  Future<List<Product>> fetchProducts() async {
    final list = await _api.fetchProducts();
    return list.map(Product.fromJson).toList();
  }
}
