// Mock data for demonstration
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';

final mockProducts = [
  Product(
    id: '1',
    name: "Men's Pullover Hoodie",
    price: 199.00,
    description:
        'Crafted with premium materials, this hoodie offers both style and comfort.',
    coverImage: 'assets/images/men_pullover_hoodie_brown.webp',
    imageUrls: [''],
    colors: ['#E5A855', '#000000', '#87CEEB', '#D3D3D3'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL'],
    category: 'Trending',
  ),
  Product(
    id: '2',
    name: "Men's Casual Shirt",
    price: 89.00,
    description: 'Perfect for any occasion, made with breathable fabric.',
    coverImage: 'assets/images/Male_T-Shirt_Mixed.jpg',
    imageUrls: [''],
    colors: ['#FFFFFF', '#87CEEB', '#FFB6C1'],
    sizes: ['S', 'M', 'L', 'XL'],
    category: 'Shirts',
  ),
  Product(
    id: '3',
    name: "Dooley Luxury Bag (Multi-Color)",
    price: 89.00,
    description: 'Perfect for any occasion, made with breathable fabric.',
    coverImage: 'assets/images/Dooley-Orange.jpg',
    imageUrls: ['assets/images/Dooley-Orange.jpg'],
    colors: ['#FFFFFF', '#87CEEB', '#FFB6C1'],
    sizes: ['S', 'M', 'L', 'XL'],
    category: 'Bag',
  ),
  Product(
      id: '4',
      name: 'Panasonic 65inch 4k Led Smart TV (ANDROID) ',
      price: 999.99,
      description: 'Natural Colour with 6-Colour Reproduction. ',
      coverImage: 'assets/images/smart_tv.webp',
      imageUrls: [''],
      colors: ['#FFFFFF', '#87CEEB', '#FFB6C1'],
      sizes: ['S', 'M', 'L', 'XL'],
      category: 'Shows'),
  Product(
    id: '5',
    name: "Gucci Medium Luxury Marmont Ld05",
    price: 89.00,
    description: 'Perfect for any occasion, made with breathable fabric.',
    coverImage: 'assets/images/gucci_medium_marmont.avif',
    imageUrls: ['assets/images/Dooley-Orange.jpg', ''],
    colors: ['#FFFFFF', '#87CEEB', '#FFB6C1'],
    sizes: ['S', 'M', 'L', 'XL'],
    category: 'Bag',
  ),
  Product(
      id: '6',
      name: 'JBL BoomBox ',
      price: 960.00,
      description: 'Natural Colour with 6-Colour Reproduction. ',
      coverImage: 'assets/images/jblBoomBox_full_view.jpg',
      imageUrls: [
        'assets/images/jblBoomBox_full_view.jpg',
        'assets/images/jblBoomBox_full_view.jpg'
      ],
      colors: ['#FFFFFF', '#87CEEB', '#FFB6C1'],
      sizes: ['S', 'M', 'L', 'XL'],
      category: 'Shows'),
  Product(
      id: '7',
      name: 'JBL PartyBox ',
      price: 499.99,
      description: 'Natural Colour with 6-Colour Reproduction. ',
      coverImage: 'assets/images/jblPartyBox_full_view.jpg',
      imageUrls: [''],
      colors: ['#FFFFFF', '#87CEEB', '#FFB6C1'],
      sizes: ['S', 'M', 'L', 'XL'],
      category: 'Shows'),
];

// Products provider
final productsProvider = FutureProvider<List<Product>>((ref) async {
  // In production, use the API service:
  // final apiService = ref.watch(apiServiceProvider);
  // final data = await apiService.getProducts();
  // return data.map((json) => Product.fromJson(json)).toList();

  // For demo, return mock data
  await Future.delayed(const Duration(milliseconds: 500));
  return mockProducts;
});

// Filtered products by category
final filteredProductsProvider =
    Provider.family<AsyncValue<List<Product>>, String?>((ref, category) {
  final productsAsync = ref.watch(productsProvider);

  return productsAsync.when(
    data: (products) {
      if (category == null || category == 'Trending') {
        return AsyncValue.data(products);
      }
      return AsyncValue.data(
        products.where((p) => p.category == category).toList(),
      );
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

// Selected category provider
final selectedCategoryProvider = StateProvider<String>((ref) => 'Trending');
