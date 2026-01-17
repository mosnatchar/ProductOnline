import 'package:flutter/material.dart';
import '../data/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(
            product.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: product.thumbnail.isEmpty
                ? const Center(child: Icon(Icons.image_not_supported, size: 64))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          const SizedBox(height: 16),

          Text(
            product.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),

          Text(
            '฿ ${product.price}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 16),

           Text(
            product.description,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),

          // ถ้า Product model ของคุณมี field อื่น (เช่น description) ก็ใส่เพิ่มได้
          // Text(product.description ?? ''),
        ],
      ),
    );
  }
}
