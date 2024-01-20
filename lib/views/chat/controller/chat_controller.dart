import 'package:dio/dio.dart';
import 'package:frontend/config.dart';
import 'package:frontend/controllers/polygon_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final Dio _dio = Dio();
  final polygon = Get.put(PolygonController());
  final MessagesList = [].obs;

  void sendTextMessage(String text) async {
    final ndvi = polygon.ndvi.value.mean;
    final evi = polygon.evi.value.mean;
    final evi2 = polygon.evi2.value.mean;
    final nri = polygon.nri.value.mean;
    final dswi = polygon.dswi.value.mean;
    final ndwi = polygon.ndwi.value.mean;

    try {
      MessagesList.add({"author": "user", "content": text});
      //add api bearer token in headers

      _dio.options.headers["content-Type"] = "application/json";
      _dio.options.headers["Authorization"] = "Bearer ${authToken}";

      var response = await _dio.post(
          "https://us-central1-aiplatform.googleapis.com/v1/projects/genai-404319/locations/us-central1/publishers/google/models/chat-bison:predict",
          data: {
            "instances": [
              {
                "context":
                    "Answer in  Compare the agricultural health and productivity of a given region by analyzing the following vegetation indices: NDVI (Normalized Difference Vegetation Index): ${ndvi}, EVI (Enhanced Vegetation Index): ${evi}, EVI2 (Second-Generation Enhanced Vegetation Index): ${evi2}, NRI (Normalized Burn Ratio): ${nri}, DSWI (Drought Stress Water Index): ${dswi}, and NDWI (Normalized Difference Water Index): ${ndwi}. Provide insights into crop vitality, drought stress, and water availability based on the values of these indices for comprehensive agricultural planning and management",
                "examples": [],
                "messages": [
                  {"author": "user", "content": "${text}"}
                ]
              }
            ],
            "parameters": {
              "candidateCount": 1,
              "maxOutputTokens": 1249,
              "temperature": 0.9,
              "topP": 1
            }
          });
      MessagesList.add({
        "author": "bot",
        "content": response.data["predictions"][0]["candidates"][0]["content"]
      });
      print("response: ${response.data}");
    } catch (e) {
      print(e);
    }
  }
}
