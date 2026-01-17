class Product {
  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        title: json['title'] as String,
        price: json['price'] as num,
        description: json['description'] as String,
        thumbnail: (json['thumbnail'] ?? '') as String,
      );
}
