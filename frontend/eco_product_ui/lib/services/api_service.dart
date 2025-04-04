import 'dart:convert';
import 'package:eco_product_ui_updated/model/DiscModel.dart';
import 'package:eco_product_ui_updated/my_models/addresses_model.dart';
import 'package:eco_product_ui_updated/my_models/cards_model.dart';
import 'package:eco_product_ui_updated/my_models/cart_model.dart';
import 'package:eco_product_ui_updated/my_models/categories_model.dart';
import 'package:eco_product_ui_updated/my_models/orders_model.dart';
import 'package:eco_product_ui_updated/my_models/register.dart';
import 'package:eco_product_ui_updated/my_models/sub_category_model.dart';
import 'package:eco_product_ui_updated/my_models/user_model.dart';

import 'custom_http_client.dart';
import 'token_storage.dart';

class ApiService {
  // static const String baseUrl = 'http://localhost:3000';
  static const String baseUrl = 'https://6386-2405-4800-5714-21a0-3c70-1832-a982-afa2.ngrok-free.app';
  final TokenStorage _tokenStorage = TokenStorage();
  final _client = CustomHttpClient();

// Initialize ApiService and load token if exists
  Future<void> init() async {
    final token = await _tokenStorage.getToken();
    if (token != null) {
      await _tokenStorage.saveToken(token);
    }
  }

  // Get stored token
  Future<String?> get token => _tokenStorage.getToken();

  // Authentication
  Future<bool> login(String email, String password) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['data']['token'];
        // Save token
        await _tokenStorage.saveToken(token);
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    await _tokenStorage.removeToken();
  }

  // Helper method to get auth headers
  Future<Map<String, String>> get _headers async {
    final token = await _tokenStorage.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Lấy danh sách slider
  Future<List<DiscModel>> getSliders() async {
    try {
      final headers = await _headers;
      final response = await _client.get(
        Uri.parse('$baseUrl/sliders'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['data'] as List)
            .map((item) => DiscModel.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load sliders');
    } catch (e) {
      throw Exception('Error getting sliders: $e');
    }
  }

  // Lấy danh sách categories
  Future<List<CategoriesModel>> getCategories() async {
    try {
      final headers = await _headers;
      final response = await _client.get(
        Uri.parse('$baseUrl/categories'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['data'] as List)
            .map((item) => CategoriesModel.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load categories');
    } catch (e) {
      throw Exception('Error getting categories: $e');
    }
  }

  // Lấy danh sách products theo type
  Future<List<SubCategoriesModel>> getProducts({
    String? type,
    String? search,
    int? categoryId,
  }) async {
    try {
      final headers = await _headers;

      // Build query parameters
      final queryParams = {
        if (type != null) 'type': type,
        if (search != null && search.isNotEmpty) 'search': search,
        if (categoryId != null) 'categoryId': categoryId.toString(),
      };

      final uri =
          Uri.parse('$baseUrl/products').replace(queryParameters: queryParams);

      final response = await _client.get(
        uri,
        headers: headers,
      );

      // print('API Response: ${response.body}'); // Print raw response

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];

        // print('Parsed data length: ${data.length}'); // Print length of data

        return data.map((item) {
          // print('Mapping item: $item'); // Print each item being mapped
          return SubCategoriesModel.fromJson(item);
        }).toList();
      }
      throw Exception('Failed to load products');
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }

  Future<SubCategoriesModel> getProductDetail(int id) async {
    try {
      final headers = await _headers;
      final response = await _client.get(
        Uri.parse('$baseUrl/products/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return SubCategoriesModel.fromJson(data['data']);
      }
      throw Exception('Failed to load product detail');
    } catch (e) {
      throw Exception('Error getting product detail: $e');
    }
  }

  // Lay chi tiet tai khoan
  Future<UserModel> getUserDetail() async {
    try {
      final headers = await _headers;
      final response = await _client.get(
        Uri.parse('$baseUrl/users/detail'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserModel.fromJson(data['data']);
      }
      throw Exception('Failed to load user detail');
    } catch (e) {
      throw Exception('Error getting user detail: $e');
    }
  }

  // Cap nhat tai khoan
  Future<UserModel> updateUser({
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? phone,
    int? defaultAddressId,
  }) async {
    try {
      final headers = await _headers;
      final response = await _client.put(
        Uri.parse('$baseUrl/users/update'),
        headers: {
          ...headers,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          if (firstName != null) 'firstName': firstName,
          if (lastName != null) 'lastName': lastName,
          if (email != null) 'email': email,
          if (gender != null) 'gender': gender,
          if (phone != null) 'phone': phone,
          if (defaultAddressId != null) 'defaultAddressId': defaultAddressId,
        }),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(json.decode(response.body)['data']);
      }
      throw Exception('Failed to update user');
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  // Dang ky tai khoan moi
  Future<UserModel> register(RegisterRequest request) async {
    try {
      print('Register URL: $baseUrl/auth/register');
      print('Register body: ${json.encode(request.toJson())}');

      final response = await _client.post(Uri.parse('$baseUrl/auth/register'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(request.toJson()));

      print('Register response status: ${response.statusCode}');
      print('Register response body: ${response.body}');

      if (response.statusCode == 201) {
        return UserModel.fromJson(json.decode(response.body)['data']);
      }
      throw Exception(
          json.decode(response.body)['message'] ?? 'Registration failed');
    } catch (e) {
      print('Register error: $e');
      throw Exception('Failed to register: $e');
    }
  }

  // Lay danh sach san pham yeu thich
  Future<List<SubCategoriesModel>> getFavorites() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/favorites'),
        headers: await _headers,
      );

      // print('Favorites response status: ${response.statusCode}');
      // print('Favorites response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['data'] as List)
            .map((item) => SubCategoriesModel.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load favorites');
    } catch (e) {
      print('Error getting favorites: $e');
      throw Exception('Error getting favorites: $e');
    }
  }

  // Huy bo san pham yeu thich
  Future<void> removeFavorite(int id) async {
    try {
      print('Removing favorite id: $id');
      final response = await _client.delete(
        Uri.parse('$baseUrl/favorites/$id'),
        headers: await _headers,
      );

      print('Remove favorite response status: ${response.statusCode}');
      print('Remove favorite response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to remove favorite');
      }
    } catch (e) {
      print('Error removing favorite: $e');
      throw Exception('Error removing favorite: $e');
    }
  }

  // Them san pham yeu thich
  Future<void> addFavorite(int productId) async {
    try {
      print('Adding favorite for product id: $productId');
      final response = await _client.post(
        Uri.parse('$baseUrl/favorites/$productId'),
        headers: await _headers,
      );

      print('Add favorite response status: ${response.statusCode}');
      print('Add favorite response body: ${response.body}');

      if (response.statusCode != 201) {
        throw Exception('Failed to add favorite');
      }
    } catch (e) {
      print('Error adding favorite: $e');
      throw Exception('Error adding favorite: $e');
    }
  }

  // Them dia chi moi
  Future<void> createAddress(Map<String, dynamic> addressData) async {
    try {
      print('Creating address with data: $addressData');
      final response = await _client.post(Uri.parse('$baseUrl/addresses'),
          headers: await _headers, body: json.encode(addressData));

      print('Create address response status: ${response.statusCode}');
      print('Create address response body: ${response.body}');

      if (response.statusCode != 201) {
        throw Exception('Failed to create address');
      }
    } catch (e) {
      print('Error creating address: $e');
      throw Exception('Error creating address: $e');
    }
  }

  // Lay danh sach dia chi
  Future<List<AddressesModel>> getUserAddresses() async {
    try {
      print('Getting user addresses...');
      final response = await _client.get(
        Uri.parse('$baseUrl/addresses/user'),
        headers: await _headers,
      );

      print('Get addresses response status: ${response.statusCode}');
      print('Get addresses response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['data'] as List)
            .map((item) => AddressesModel.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load addresses');
    } catch (e) {
      print('Error getting addresses: $e');
      throw Exception('Error getting addresses: $e');
    }
  }

  // Lay danh sach thanh toan
  Future<List<CardsModel>> getPayments() async {
    try {
      print('Getting payments...');
      final response = await _client.get(
        Uri.parse('$baseUrl/payments'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['data'] as List)
            .map((item) => CardsModel.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load payments');
    } catch (e) {
      throw Exception('Error getting payments: $e');
    }
  }

  // Lay danh sach don hang
  Future<CartModel> getCart() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/cart'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CartModel.fromJson(data['data']);
      }

      throw Exception('Failed to load cart');
    } catch (e) {
      throw Exception('Error getting cart: $e');
    }
  }

  // Them so luong san pham trong gio hang
  Future<void> updateCartItemQuantity(
      int itemId, int quantity, String operation) async {
    try {
      final response = await _client.post(
          Uri.parse('$baseUrl/cart/items/$itemId/quantity'),
          headers: {...await _headers, 'Content-Type': 'application/json'},
          body: json.encode({'quantity': quantity, 'operation': operation}));

      if (response.statusCode != 201) {
        throw Exception('Failed to update quantity');
      }
    } catch (e) {
      throw Exception('Error updating quantity: $e');
    }
  }

  // Them san pham vao gio hang
  Future<void> addToCart(int productId, int quantity) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/cart/items'),
        headers: {...await _headers, 'Content-Type': 'application/json'},
        body: json.encode({
          'productId': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add to cart');
      }
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  // Xoa san pham khoi gio hang
  Future<void> removeCartItem(int itemId) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/cart/items/$itemId'),
        headers: await _headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to remove item');
      }
    } catch (e) {
      throw Exception('Error removing item: $e');
    }
  }

  // Lay danh sach don hang
  Future<List<OrdersModel>> getOrders() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/orders'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['data'] as List)
            .map((item) => OrdersModel.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load orders');
    } catch (e) {
      throw Exception('Error getting orders: $e');
    }
  }

  // Tao don hang
  Future<void> checkout({
    required int addressId,
    required int paymentId,
    String? voucherCode,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/orders/checkout'),
        headers: {...await _headers, 'Content-Type': 'application/json'},
        body: json.encode({
          'addressId': addressId,
          'paymentId': paymentId,
          if (voucherCode != null) 'voucherCode': voucherCode,
        }),
      );

      // if (response.statusCode != 200) {
      //   throw Exception('Failed to checkout. Status code: ${response.statusCode}');
      // }
    } catch (e) {
      throw Exception('Error checking out: $e');
    }
  }
  
  // Cap nhat trang thai don hang
  Future<void> updateOrderStatus(int orderId, String status) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/orders/$orderId/status'),
        headers: {...await _headers, 'Content-Type': 'application/json'},
        body: json.encode({
          'status': status,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update order status');
      }
    } catch (e) {
      throw Exception('Error updating order status: $e');
    }
  }

  // Don't forget to dispose of the client when you're done
  void dispose() {
    _client.close();
  }
}
