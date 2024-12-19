import 'package:flutter/material.dart';
import 'openai_service.dart';  // Import the NvidiaService class

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  String _response = '';

  // Create an instance of NvidiaService
  NvidiaService nvidiaService = NvidiaService();

  // Function to send a message to NvidiaService
  void _sendMessage() async {
    String userMessage = _controller.text;
    if (userMessage.isNotEmpty) {
      // Get the Nvidia response asynchronously
      String response = await nvidiaService.getNvidiaResponse(userMessage);
      setState(() {
        _response = response;  // Update UI with the response
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nvidia Flutter Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask a question...',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text('Send'),
            ),
            SizedBox(height: 20),
            Text('Response: $_response'),
          ],
        ),
      ),
    );
  }
}
