import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.example.com', // Replace with your API URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add interceptors for logging
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ),
  );

  return dio;
});

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<dynamic>> getProducts({String? category}) async {
    try {
      final response = await _dio.get(
        '/products',
        queryParameters: category != null ? {'category': category} : null,
      );
      return response.data as List<dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProductById(String id) async {
    try {
      final response = await _dio.get('/products/$id');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _dio.post('/orders', data: orderData);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});
