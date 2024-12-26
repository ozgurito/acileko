import 'package:flutter/material.dart';
import 'api.service.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      String userMessage = _controller.text;

      setState(() {
        _messages.add({'sender': 'user', 'message': userMessage});
        _isLoading = true;
      });

      _controller.clear();

      try {
        var response = await ApiService.getChatbotResponse(userMessage);
        setState(() {
          _messages.add({'sender': 'bot', 'message': response});
        });
      } catch (error) {
        setState(() {
          _messages.add({
            'sender': 'bot',
            'message': 'Bir hata oluştu. Lütfen tekrar deneyin.'
          });
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  var message = _messages[index];
                  bool isUserMessage = message['sender'] == 'user';

                  return Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        message['message']!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isLoading) CircularProgressIndicator(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Sorunuzu yazın...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
