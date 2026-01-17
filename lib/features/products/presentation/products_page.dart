import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/products_cubit.dart';
import '../cubit/products_state.dart';
import '../data/products_api_service.dart';
import '../data/products_repository.dart';
import 'pages/product_detail_page.dart';
import 'widgets/product_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductsCubit(repo: ProductsRepository(api: ProductsApiService()))
            ..load(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Products List',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state.loading)
              return const Center(child: CircularProgressIndicator());

            if (state.error != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: ${state.error}'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.read<ProductsCubit>().load(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, i) {
                final p = state.products[i];
                return ProductCard(
                  product: p,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: p),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
