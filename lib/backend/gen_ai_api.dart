import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'variables.dart';

class GenAiApi {
  final _model = Variables.model;
  String? _apiKey;

  Future getApi() async {
    _apiKey = await Variables.loadApiKey();
    _aiInstance = GenerativeModel(model: _model, apiKey: _apiKey ?? '');
  }

  late final GenerativeModel _aiInstance;
  GenAiApi._() {
    getApi();
  }

  static final GenAiApi _instance = GenAiApi._();

  factory GenAiApi() {
    return _instance;
  }

  Future<String?> answerQuery(String question) async {
    var response = await _aiInstance.startChat().sendMessage(
      Content.text(question),
    );
    return response.text!.trim();
  }
}
