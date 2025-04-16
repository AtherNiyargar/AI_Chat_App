import 'package:flutter/material.dart';
import 'package:ai_app/conversations.dart';
import 'package:provider/provider.dart';

class TypeAndSend extends StatefulWidget {
  const TypeAndSend({super.key});

  @override
  State<TypeAndSend> createState() => _TypeAndSendState();
}

class _TypeAndSendState extends State<TypeAndSend> {
  late final TextEditingController queryTextController;

  late final Conversations conversations;

  @override
  void initState() {
    conversations = Conversations();
    queryTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    conversations.dispose();
    queryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.max,

        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: TextField(
                controller: queryTextController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onTapOutside:
                    (_) => FocusManager.instance.primaryFocus!.unfocus(),
                decoration: InputDecoration(
                  labelText: " Ask me anything!",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
          IconButton(
            onPressed: () {
              Provider.of<Conversations>(
                context,
                listen: false,
              ).addMessage(queryTextController.text);
              queryTextController.clear();
            },
            icon: Icon(Icons.send_rounded),
            iconSize: 50,
            splashRadius: 100,
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
        ],
      ),
    );
  }
}
