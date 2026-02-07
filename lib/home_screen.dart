import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:retail_mart/design_system/tokens/colors.dart';
import 'package:retail_mart/models/product.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    final cart = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.gray100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _topSection(),

          const SizedBox(height: 20),

          _productSection(ref),

          // Products Grid
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: AppColors.white,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(56), topRight: Radius.circular(56))
              ),
              child: productsAsync.when(
                data: (products) {
                  final filteredProducts = selectedCategory == 'Trending'
                      ? products
                      : products
                          .where((p) => p.category == selectedCategory)
                          .toList();

                  // Shuffle the filtered list for random order
                  filteredProducts.shuffle(); // Shuffle the list

                  return ListView.builder(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 56),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      // adjust index because of injected widget
                      final productIndex = index;
                      final product = filteredProducts[productIndex];

                      return _buildProductCard(context, product, ref);
                    },
                  );
                  // return GridView.builder(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     childAspectRatio: 0.75,
                  //     crossAxisSpacing: 16,
                  //     mainAxisSpacing: 16,
                  //   ),
                  //   itemCount: filteredProducts.length,
                  //   itemBuilder: (context, index) {
                  //     final product = filteredProducts[index];
                  //     return _buildProductCard(context, product, ref);
                  //   },
                  // );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
      String label, String selectedCategory, WidgetRef ref) {
    final isSelected = label == selectedCategory;
    return GestureDetector(
      onTap: () {
        ref.read(selectedCategoryProvider.notifier).state = label;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.gray100,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, product, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('product-detail', extra: product);
      },
      child: Container(
        height: 320,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Visibility(
                    visible: product.coverImage.toString().isNotEmpty,
                    child: Container(
                        margin: const EdgeInsets.all(12),
                        width: double.infinity,
                        height: 360,
                        decoration: BoxDecoration(
                          color: AppColors.gray300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              product.coverImage,
                              fit: BoxFit.cover,
                            ))),
                  ),
                  Visibility(
                    visible: product.coverImage.toString().isEmpty,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      width: double.infinity,
                      height: 360,
                      decoration: BoxDecoration(
                        color: AppColors.gray300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.checkroom,
                          size: 80,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(14),
                              topRight: Radius.circular(14))),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        // fontSize: 14,

                        // fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 8),
                      const Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topSection() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(56),
              bottomRight: Radius.circular(56))),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.person, color: Colors.white),
                ),

                const Text(
                  'Retail Mart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/bell.svg',
                  ),
                ),

//                 Stack(
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: IconButton(
//                         icon: const Icon(Icons.message_outlined),
//                         onPressed: () {},
//                       ),
//                     ),
//                     if (cart.isNotEmpty)
//                       Positioned(
//                         right: 0,
//                         top: 0,
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: const BoxDecoration(
//                             color: Colors.black,
//                             shape: BoxShape.circle,
//                           ),
//                           constraints: const BoxConstraints(
//                             minWidth: 20,
//                             minHeight: 20,
//                           ),
//                           child: Text(
//                             // '${cart.length}',
// '2',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
              ],
            ),

            const SizedBox(height: 20),
            //* Greeting
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello TOE Tech',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fashion confidence and reveals beauty.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            //* Search Bar and Filter

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/search.svg',
                          colorFilter: const ColorFilter.mode(
                            AppColors.gray600,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search here',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        // ,
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          child: const Row(
                            children: [
                              Icon(Icons.tune,
                                  color: AppColors.primary, size: 20),
                              SizedBox(width: 6),
                              Text(
                                'Filter',
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _productSection(WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return // Category Tabs
        Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(56), topRight: Radius.circular(56))),
      child: SizedBox(
        height: 38,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            _buildCategoryChip('Trending', selectedCategory, ref),
            const SizedBox(width: 12),
            _buildCategoryChip('Shows', selectedCategory, ref),
            const SizedBox(width: 12),
            _buildCategoryChip('Bag', selectedCategory, ref),
            const SizedBox(width: 12),
            _buildCategoryChip('Shirts', selectedCategory, ref),
            const SizedBox(width: 12),
            _buildCategoryChip('Arts', selectedCategory, ref),
          ],
        ),
      ),
    );
  }
}
