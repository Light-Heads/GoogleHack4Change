import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/commodity.dart';
import 'package:frontend/config.dart';

class CommodityController extends GetxController {
  var isDataLoading = false.obs;
  final Dio _dio = Dio();
  var commodity = CommodityModel().obs;
  @override
  void onInit() {
    super.onInit();
    fetchCommodityData();
  }

  Future<void> fetchCommodityData() async {
    try {
      isDataLoading(true);
      final response = await _dio.get(commodityAPIURL);
      if (response.statusCode == 200) {
        commodity.value = CommodityModel.fromJson(response.data);
        // res = commodity.value.records;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    } finally {
      isDataLoading(false);
    }
  }
}
