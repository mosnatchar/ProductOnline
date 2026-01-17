import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/products_repository.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository repo;

  ProductsCubit({required this.repo}) : super(ProductsState.initial());

  Future<void> load() async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final items = await repo.fetchProducts();
      emit(state.copyWith(loading: false, products: items));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
