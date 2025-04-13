import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/material.dart';
import 'package:progress/ai/message.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AIBot extends StatefulWidget {
  const AIBot({super.key});

  @override
  State<AIBot> createState() => _AIBotState();
}

class _AIBotState extends State<AIBot> {
  final TextEditingController _controller = TextEditingController();
  // final List<Message> _messages = [];
  // // late OpenAI? chatGPT;
  // OpenAI? chatGPT;
  // StreamSubscription? _subscription;
  final apikey = 'AIzaSyB2g7g6gccyCOBaigU78tyzJRQ6EGGrq7M';
  Future<void> talkwithai() async {
    final model =
        GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apikey);
    final msg = 'Hellow';

    final content = Content.text(msg);
    final response = await model.generateContent([content]);

    print('response from gemini: ${response.text}');
  }

  @override
  void initState() {
    super.initState();
    // chatGPT = OpenAI.instance;
  }

  @override
  void dispose() {
    // _controller.dispose();
    // _subscription?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    Message _message = Message(
      text: _controller.text,
      sender: 'user',
    );
    setState(() {
      // _messages.insert(0, _message);
    });
    _controller.clear();
  }

  Widget _buildTextCompose() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0, left: 20.0, right: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (value) => _sendMessage(),
              decoration: InputDecoration.collapsed(
                  hintText: "Ask please!!!", fillColor: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              talkwithai();
              // _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[600],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black,
        backgroundColor: Colors.deepPurple[300],
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(
          'AI Chat ',
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'ShadowsIntoLight',
              fontWeight: FontWeight.bold),
        ),
        elevation: 5,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(8.0),
                    // itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      // return _messages[index];
                    })),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[300],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: _buildTextCompose(),
            )
          ],
        ),
      ),
    );
  }
}
// Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 15,
//                     child: TextFormField(
//                       style: TextStyle(color: Colors.white),
//                       controller: _userInput,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           label: Text('Enter Your Message')),
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//                       padding: EdgeInsets.all(12),
//                       iconSize: 30,
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.black),
//                           foregroundColor:
//                               MaterialStateProperty.all(Colors.white),
//                           shape: MaterialStateProperty.all(CircleBorder())),
//                       onPressed: () {
//                         sendMessage();
//                       },
//                       icon: Icon(Icons.send))
//                 ],
//               ),
//             )
