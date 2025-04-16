import 'package:flutter/material.dart';
import 'package:ai_app/backend/gen_ai_api.dart';
import 'backend/database_functionality.dart';

class Conversations extends ChangeNotifier {
  String aiMessage = '';
  late final DatabaseFunctionality db;
  GenAiApi? genAiApi;
  final List<Map<Widget, bool>> _conversationList = [];
  List<Map<String, dynamic>> tempConv = [];
  Conversations._() {
    genAiApi = GenAiApi();
    db = DatabaseFunctionality();
    _conversationList.add({SelectableText('Ask me anything'): false});
    populateConversation();
  }

  Future<void> populateConversation() async {
    tempConv = await db.getDataFromDB();
    for (var conv in tempConv) {
      _conversationList.add({
        SelectableText(conv.values.elementAt(1)):
            conv.values.elementAt(2) == 0 ? false : true,
      });
    }
  }

  static final Conversations _instance = Conversations._();

  factory Conversations() {
    return _instance;
  }

  int getConversationsLength() => _conversationList.length;

  bool ifSentMessage(int index) => _conversationList[index].values.first;

  Widget getSingleMessage(int index) => _conversationList[index].keys.first;

  void addMessage(String newMessage) async {
    _conversationList.add({SelectableText(newMessage): true});
    db.insertData(newMessage, 1);
    notifyListeners();

    _conversationList.add({LinearProgressIndicator(): false});

    aiMessage = await genAiApi!.answerQuery(newMessage) as String;

    _conversationList.last = {SelectableText(aiMessage): false};
    db.insertData(aiMessage, 0);
    notifyListeners();
  }
}
