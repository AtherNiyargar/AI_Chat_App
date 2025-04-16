import 'package:ai_app/conversations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({super.key});

  @override
  State<ConversationList> createState() => _ConversationListState();
}

late final Conversations conversations;

class _ConversationListState extends State<ConversationList> {
  @override
  void initState() {
    conversations = Conversations();
    super.initState();
  }

  @override
  void dispose() {
    conversations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.of(context).size.width;

    return Consumer(
      builder: (conversationContext, value, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: conversations.getConversationsLength(),
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment:
                    conversations.ifSentMessage(index)
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: windowWidth * 0.85),
                      decoration: BoxDecoration(
                        color:
                            conversations.ifSentMessage(index)
                                ? Theme.of(context).colorScheme.inversePrimary
                                : Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: conversationContext
                          .watch<Conversations>()
                          .getSingleMessage(index),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
