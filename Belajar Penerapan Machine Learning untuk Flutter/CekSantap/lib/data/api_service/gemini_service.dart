import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/nutrition_model.dart';

class GeminiService {
  static const String baseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-lite:generateContent";

  final String apiKey;

  GeminiService({required this.apiKey});

  Future<Nutrition?> getNutrition(String foodName) async {
    final url = Uri.parse("$baseUrl?key=$apiKey");

    final body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": "Nama makanannya adalah $foodName."}
          ]
        }
      ],
      "systemInstruction": {
        "parts": [
          {
            "text":
            "Saya adalah suatu mesin yang mampu mengidentifikasi nutrisi atau kandungan gizi pada makanan layaknya uji laboratorium makanan. Hal yang bisa diidentifikasi adalah kalori, karbohidrat, lemak, serat, dan protein pada makanan. Satuan dari indikator tersebut berupa gram."
          }
        ]
      },
      "generationConfig": {
        "responseMimeType": "application/json",
        "responseSchema": {
          "type": "object",
          "required": ["calories", "carbs", "protein", "fat", "fiber"],
          "properties": {
            "calories": {"type": "integer"},
            "carbs": {"type": "integer"},
            "protein": {"type": "integer"},
            "fat": {"type": "integer"},
            "fiber": {"type": "integer"}
          }
        }
      }
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["candidates"] != null &&
          data["candidates"].isNotEmpty &&
          data["candidates"][0]["content"]["parts"] != null &&
          data["candidates"][0]["content"]["parts"].isNotEmpty) {
        final text = data["candidates"][0]["content"]["parts"][0]["text"];
        final nutritionJson = jsonDecode(text);
        return Nutrition.fromJson(nutritionJson);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
