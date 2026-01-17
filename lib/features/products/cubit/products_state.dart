import 'package:equatable/equatable.dart';
import '../data/product_model.dart';

class ProductsState extends Equatable {
  final bool loading;
  final List<Product> products;
  final String? error;

  const ProductsState({
    required this.loading,
    required this.products,
    this.error,
  });

  factory ProductsState.initial() =>
      const ProductsState(loading: false, products: []);

  ProductsState copyWith({
    bool? loading,
    List<Product>? products,
    String? error,
  }) =>
      ProductsState(
        loading: loading ?? this.loading,
        products: products ?? this.products,
        error: error,
      );

  @override
  List<Object?> get props => [loading, products, error];
}
