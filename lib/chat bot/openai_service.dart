import 'dart:convert';
import 'package:http/http.dart' as http;

class NvidiaService {
  final String apiKey = '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'; // Replace with your actual NVIDIA API key
  final String endpoint = 'https://integrate.api.nvidia.com/v1';

  // Function to get response from NVIDIA API
  Future<String> getNvidiaResponse(String userMessage) async {
    // Set up the headers for the HTTP request
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey', // Bearer token for authentication
    };

    // Set up the body of the request
    final body = jsonEncode({
      'model': 'nvidia/llama-3.1-nemotron-70b-instruct',
      'messages': [
        {'role': 'user', 'content': userMessage}
      ],
      'temperature': 0.5,
      'top_p': 1,
      'max_tokens': 1024,
      'stream': true
    });

    try {
      // Send the HTTP POST request to NVIDIA API
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // If the response is successful, parse the response
        final responseData = jsonDecode(response.body);

        // Assuming the streaming response is in chunks, you will need to handle it accordingly.
        // In this example, we just print out the response.
        String responseMessage = '';
        for (var chunk in responseData['choices']) {
          if (chunk['delta']['content'] != null) {
            responseMessage += chunk['delta']['content'];
          }
        }
        return responseMessage;  // Return the full response
      } else {
        // If the response is not successful, throw an error
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      // Catch any exceptions and return a message
      return 'Error: $e';
    }
  }
}
