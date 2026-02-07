import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product, String size, String color) {
    final existingIndex = state.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );

    if (existingIndex >= 0) {
      // Update quantity if item already exists
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i],
      ];
    } else {
      // Add new item
      state = [
        ...state,
        CartItem(
          product: product,
          quantity: 1,
          selectedSize: size,
          selectedColor: color,
        ),
      ];
    }
  }

  void updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      removeFromCart(index);
      return;
    }

    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(quantity: quantity) else state[i],
    ];
  }

  void removeFromCart(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  void clearCart() {
    state = [];
  }

  double get subtotal {
    return state.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get deliveryFee => 16.00;

  double get total => subtotal + deliveryFee;
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// Cart totals provider
final cartTotalsProvider = Provider<Map<String, double>>((ref) {
  final cart = ref.watch(cartProvider.notifier);
  return {
    'subtotal': cart.subtotal,
    'deliveryFee': cart.deliveryFee,
    'total': cart.total,
  };
});
