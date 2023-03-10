// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

// Models
import 'models/models.dart';

class ProductsRepository {
  final HttpClient _httpClient;

  ProductsRepository(this._httpClient);

  /// **Get products**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return list product
  Future<List<Product>> getProducts({required RequestData requestData}) async {
    try {
      List<dynamic> res = (await _httpClient.get(
        Endpoints.getProducts,
        data: requestData,
      )) as List;
      List<Product> products = List<Product>.of([]);
      if (res.isNotEmpty) {
        products = res.map((e) => Product.fromJson(e)).toList().cast<Product>();
      }
      return products;
    } catch (_) {
      rethrow;
    }
  }

  /// **Get advanced products**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, productId
  ///
  /// **Returns:**
  ///
  /// Return advanced product
  Future<dynamic> getAdvancedProduct({required int productId, required RequestData requestData}) async {
    try {
      final res = await _httpClient.get(
        "${Endpoints.getAdvancedProducts}/$productId",
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// **Add product**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return a product
  Future<dynamic> addProducts({required RequestData requestData}) async {
    try {
      var res = (await _httpClient.post(
        Endpoints.getProducts,
        data: requestData,
      ));
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// **Update product**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, productId
  ///
  /// **Returns:**
  ///
  /// Return a product
  Future<Product> updateProduct({required int idProduct, required RequestData requestData}) async {
    try {
      var res = (await _httpClient.post(
        "${Endpoints.getProducts}/$idProduct",
        data: requestData,
      ));
      return Product.fromJson(res);
    } catch (_) {
      rethrow;
    }
  }

  /// **Update advanced product**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, productId
  ///
  /// **Returns:**
  ///
  /// Return a product
  Future<Product> updateAdvancedProduct({required int idProduct, required RequestData requestData}) async {
    try {
      var res = (await _httpClient.post(
        "${Endpoints.getAdvancedProducts}/$idProduct",
        data: requestData,
      ));
      return Product.fromJson(res);
    } catch (_) {
      rethrow;
    }
  }

  /// **Delete products with [productId]**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// productId: (**type int**) [productId] is ID of product
  ///
  /// **Returns:**
  ///
  /// Return a product which just delete
  Future<Product> deleteProducts({
    required RequestData requestData,
    required int productId,
  }) async {
    try {
      var res = (await _httpClient.delete(
        "${Endpoints.getProducts}/$productId",
        data: requestData,
      ));
      return Product.fromJson(res);
    } catch (_) {
      rethrow;
    }
  }

  /// **Get attributes**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return list attributes
  Future<dynamic> getAttributes({required RequestData requestData}) async {
    try {
      final res = await _httpClient.get(
        Endpoints.getAttributes,
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// **Get term attributes**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return list term attributes
  Future<dynamic> getTermAttributes({required int id, required RequestData requestData}) async {
    try {
      final res = await _httpClient.get(
        "${Endpoints.getAttributes}/$id/terms",
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// **Get list variation of product**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, id product
  ///
  /// **Returns:**
  ///
  /// Return list variations
  Future<dynamic> getListVariation({
    required int idProduct,
    required RequestData requestData,
  }) async {
    try {
      final res = await _httpClient.get(
        "${Endpoints.getProducts}/$idProduct/variations",
        data: requestData,
      );
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.of([]);
      if (res.isNotEmpty) {
        data = res.map((e) => e).toList().cast<Map<String, dynamic>>();
      }
      return data;
    } catch (_) {
      rethrow;
    }
  }

  /// **Update variation**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, id product, id variation
  ///
  /// **Returns:**
  ///
  /// Return a variation
  Future<dynamic> updateVariation({
    required int idProduct,
    required int idVariation,
    required RequestData requestData,
  }) async {
    try {
      final res = await _httpClient.post(
        "${Endpoints.getProducts}/$idProduct/variations/$idVariation",
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// **Add variation**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, id product,
  ///
  /// **Returns:**
  ///
  /// Return a variation
  Future<dynamic> addVariation({
    required int idProduct,
    required RequestData requestData,
  }) async {
    try {
      final res = await _httpClient.post(
        "${Endpoints.getProducts}/$idProduct/variations",
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// **Get variation**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, id product, id variation
  ///
  /// **Returns:**
  ///
  /// Return a variation
  Future<dynamic> getVariation({
    required int idProduct,
    required int idVariation,
    required RequestData requestData,
  }) async {
    try {
      final res = await _httpClient.get(
        '${Endpoints.getProducts}/$idProduct/variations/$idVariation',
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// **Delete variation with [productId, variationId]**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// productId: (**type int**) [productId] is ID of product
  /// variationId: (**type int**) [variationId] is ID of variation
  ///
  /// **Returns:**
  ///
  /// Return a product which just delete
  Future<dynamic> deleteVariation({
    required int idProduct,
    required int idVariation,
    required RequestData requestData,
  }) async {
    try {
      var res = (await _httpClient.delete(
        "${Endpoints.getProducts}/$idProduct/variations/$idVariation",
        data: requestData,
      ));
      return res;
    } catch (_) {
      rethrow;
    }
  }
}
