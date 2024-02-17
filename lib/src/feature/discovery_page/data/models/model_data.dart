import 'package:flutter_together/src/feature/discovery_page/data/models/info_data.dart';

//Model Class for Response
class ModelData {
  final List<InfoData> data;
  final int page;
  final int count;

  ModelData({
    required this.data,
    required this.page,
    required this.count,
  });

  //FromJson function to parse the response from the API and convert it to the ModelData object
  factory ModelData.fromJson(Map<String, dynamic> json) {
    return ModelData(
      data: List<InfoData>.from(json['data'].map((x) => InfoData.fromJson(x))),
      page: json['page'],
      count: json['count'],
    );
  }
}
