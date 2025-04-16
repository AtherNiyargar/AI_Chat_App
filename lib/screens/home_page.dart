import 'package:ai_app/conversations.dart';
import 'package:ai_app/screens/home_page_parts/type_and_send.dart';
import 'package:provider/provider.dart';
import 'home_page_parts/conversation_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Conversations(),

      child: Scaffold(
        appBar: AppBar(title: Text("AI Hype Train 🤡"), centerTitle: true),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [ConversationList(), TypeAndSend()]),
        ),
      ),
    );
  }
}
