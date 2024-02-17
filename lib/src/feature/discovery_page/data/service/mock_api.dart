import 'dart:convert';

import 'package:flutter_together/src/feature/discovery_page/data/models/model_data.dart';
import 'package:http/http.dart' as http;

//Mock API class to fetch data from the API
class MockApi {
  Future<ModelData> fetchPages({int page = 1, bool isRefresh = false}) async {
    if (isRefresh) {
      page = 1;
    }

    final url =
        'https://api-stg.together.buzz/mocks/discovery?page=$page&limit=10';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //map data to model
      final jsonDecode = json.decode(response.body);
      ModelData model = ModelData.fromJson(jsonDecode);
      //return model
      return model;
    } else {
      throw "Failed to load page";
    }
  }
}
