import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _userInput = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  static const apiKey = "your-api-key";

  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  final List<Message> _messages = [];

  Future<void> sendMessage() async {
    final message = _userInput.text;
    if (message.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _messages.add(
        Message(isUser: true, message: message, date: DateTime.now()),
      );
    });

    _userInput.clear();
    _scrollToBottom();

    try {
      final content = [Content.text(message)];
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(
          Message(
            isUser: false,
            message: response.text ?? "Error: No response",
            date: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() => _isLoading = false);
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildTextCompose() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0, left: 20.0, right: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _userInput,
              enabled: !_isLoading,
              decoration: InputDecoration.collapsed(
                hintText:
                    _isLoading ? "Waiting for response..." : "Ask please!!!",
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isLoading ? null : sendMessage,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _userInput.dispose();
    _scrollController.dispose();
    super.dispose();
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
        title: const Text(
          'AI Chat',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'ShadowsIntoLight',
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 5,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                );
              },
            ),
          ),
          Column(
            children: [
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: _buildTextCompose(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({
    required this.isUser,
    required this.message,
    required this.date,
  });
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  void _showCopyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("💬 Options",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("Would you like to copy this response?"),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: message));
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: "Copied to Clipboard!",
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
              );
            },
            child:
                const Text("Copy", style: TextStyle(color: Colors.deepPurple)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAI = !isUser;
    return GestureDetector(
      onLongPress: () {
        if (isAI) {
          _showCopyDialog(context);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(vertical: 15)
            .copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
        decoration: BoxDecoration(
          color: isUser
              ? Colors.deepPurple[300]
              : const Color.fromARGB(255, 245, 198, 213),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
            topRight: const Radius.circular(10),
            bottomRight: isUser ? Radius.zero : const Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isUser
                ? Text(
                    message,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  )
                : MarkdownBody(
                    data: message,
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(fontSize: 16, color: Colors.black),
                      strong: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
            Text(
              date,
              style: TextStyle(
                fontSize: 10,
                color: isUser ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
