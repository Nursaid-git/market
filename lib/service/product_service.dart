import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

class ProductService {
  final _supabase = Supabase.instance.client;

  Future<List<ProductModel>> fetchProducts() async {
    final response = await _supabase.from('products').select();
    return (response as List).map((e) => ProductModel.fromJson(e)).toList();
  }
  Future<ProductModel> fetchProductById(String id) async {
    final response = await _supabase.from('products').select().eq('id', id).single();
    return ProductModel.fromJson(response);
  }
}