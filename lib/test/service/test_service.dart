import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/test_model.dart';

class TestService {
final SupabaseClient client = Supabase.instance.client;

  Future<List<TestModel>> getProducts() async {
    try {
      final responce = await client.from('test_models').select();

      return responce.map((e) => TestModel.fromJson(e)).toList();
    } catch (e) {
      throw e;
    }
  }
}