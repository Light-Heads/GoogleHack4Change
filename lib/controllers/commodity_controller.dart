import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/commodity.dart';

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
      final response = await _dio.get(
          'https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b&format=json&limit=100');
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
