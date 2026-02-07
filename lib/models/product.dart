class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final List<String> imageUrls;
  final String coverImage;
  final List<String> colors;
  final List<String> sizes;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrls,
    required this.coverImage,
    required this.colors,
    required this.sizes,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      coverImage: json['coverImage'] ?? '',
      imageUrls: List<String>.from(json['imageUrl'] ?? ''),
      colors: List<String>.from(json['colors'] ?? []),
      sizes: List<String>.from(json['sizes'] ?? []),
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'coverImage': coverImage,
      'imageUrl': imageUrls,
      'colors': colors,
      'sizes': sizes,
      'category': category,
    };
  }
}
