import 'package:dio/dio.dart';
import 'package:frontend/config.dart';
import 'package:frontend/controllers/language_controller.dart';
import 'package:frontend/controllers/polygon_controller.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final Dio _dio = Dio();
  final polygon = Get.put(PolygonController());
  final MessagesList = [
    {
      "author": "Sahay",
      "content":
          "Welcome to Sahay, I am Sahay, your personal assistant. I can help you with your queries regarding agriculture. I can also assist you in Hindi"}
  ].obs;
  final chat = Get.put(LanguageController());
  final user = Get.put(UserController());

  void sendTextMessage(String text) async {
    final ndvi = polygon.ndvi.value.mean;
    final evi = polygon.evi.value.mean;
    final evi2 = polygon.evi2.value.mean;
    final nri = polygon.nri.value.mean;
    final dswi = polygon.dswi.value.mean;
    final ndwi = polygon.ndwi.value.mean;

    try {
      MessagesList.add({"author": "${user.user.value.name}", "content": text});
      //add api bearer token in headers

      _dio.options.headers["content-Type"] = "application/json";
      _dio.options.headers["Authorization"] = "Bearer ${authToken}";

      var response = await _dio.post(
          "https://us-central1-aiplatform.googleapis.com/v1/projects/genai-404319/locations/us-central1/publishers/google/models/chat-bison:predict",
          data: {
            "instances": [
              {
                "context":
                    "Answer in ${chat.value.value} Compare the agricultural health and productivity of a given region by analyzing the following vegetation indices: NDVI (Normalized Difference Vegetation Index): ${ndvi}, EVI (Enhanced Vegetation Index): ${evi}, EVI2 (Second-Generation Enhanced Vegetation Index): ${evi2}, NRI (Normalized Burn Ratio): ${nri}, DSWI (Drought Stress Water Index): ${dswi}, and NDWI (Normalized Difference Water Index): ${ndwi}. Provide insights into crop vitality, drought stress, and water availability based on the values of these indices for comprehensive agricultural planning and management. Dont give vague answers, give definitive suggestions.",
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
        "author": "Sahay",
        "content": response.data["predictions"][0]["candidates"][0]["content"]
      });
      print("response: ${response.data}");
    } catch (e) {
      print(e);
    }
  }
}
