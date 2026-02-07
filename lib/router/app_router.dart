import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:retail_mart/cart_screen.dart';
import 'package:retail_mart/home_screen.dart';
import 'package:retail_mart/models/product.dart';
import 'package:retail_mart/product_detail_screen.dart';
import 'package:retail_mart/profile_screen.dart';
import 'package:retail_mart/router/main_shell.dart';
import 'package:retail_mart/shop_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/product/:id',
        name: 'product-detail',
        builder: (context, state) {
          final product = state.extra as Product;
          return ProductDetailScreen(product: product);
        },
      ),

      // ✅ ShellRoute WITH nav bar
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/shop',
            name: 'shop',
            builder: (context, state) => const ShopScreen(),
          ),
          GoRoute(
            path: '/cart',
            name: 'cart',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});
