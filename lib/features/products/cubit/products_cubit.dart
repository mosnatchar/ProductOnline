import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/dio_error_mapper.dart';
import '../data/products_repository.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.repo}) : super(ProductsState.initial());
  final ProductsRepository repo;

  Future<void> load() async {
    if (state.loading) return;

    emit(state.copyWith(loading: true, error: null));

    try {
      final items = await repo.fetchProducts();
      emit(state.copyWith(loading: false, products: items));
    } on DioException catch (e) {
      emit(state.copyWith(loading: false, error: e.toUserMessage()));
    } catch (_) {
      emit(state.copyWith(loading: false, error: 'เกิดข้อผิดพลาด กรุณาลองใหม่'));
    }
  }
}
