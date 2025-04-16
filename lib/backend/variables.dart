import 'package:flutter_dotenv/flutter_dotenv.dart';

class Variables {
  static String? apiKey;
  static String model = 'gemini-2.0-flash';
  static Future<String> loadApiKey() async {
    await dotenv.load();
    apiKey = dotenv.env['GEMINI_API_KEY'];
    return apiKey ?? '';
  }
}
