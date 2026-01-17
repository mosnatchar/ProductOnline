import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';
import '../cubit/products_state.dart';
import '../data/products_repository.dart';
import 'product_detail_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(repo: ProductsRepository())..load(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Products List')),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }
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
                crossAxisCount: 2,           // ✅ 2 คอลัมน์
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.72,      // ปรับให้การ์ดไม่เตี้ย/สูงเกิน
              ),
              itemCount: state.products.length,
              itemBuilder: (context, i) {
                final p = state.products[i];

                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: p),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Color(0xFFBDBDBD)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // รูป
                        AspectRatio(
                          aspectRatio: 1, // ทำให้รูปเป็นสี่เหลี่ยม
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: p.thumbnail.isEmpty
                                ? const Center(child: Icon(Icons.image_not_supported))
                                : Image.network(
                                    p.thumbnail,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        // ข้อมูล
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '฿ ${p.price}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
