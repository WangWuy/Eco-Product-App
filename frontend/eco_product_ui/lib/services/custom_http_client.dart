import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class CustomHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Log request
    developer.log('🌐 REQUEST:', name: 'HTTP', error: '''
URL: ${request.url}
Method: ${request.method}
Headers: ${request.headers}
''');

    // If it's a POST/PUT request with a body, log the body
    if (request is http.Request) {
      developer.log('Body: ${request.body}', name: 'HTTP');
    }

    final response = await _inner.send(request);

    // Convert StreamedResponse to Response to read body
    final responseBody = await http.Response.fromStream(response);

    // Log response
    developer.log('📩 RESPONSE:', name: 'HTTP', error: '''
Status Code: ${response.statusCode}
Headers: ${response.headers}
Body: ${responseBody.body}
''');

    // Return a new StreamedResponse with the same data
    return http.StreamedResponse(
      Stream.value(responseBody.bodyBytes),
      response.statusCode,
      headers: response.headers,
      contentLength: response.contentLength,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }
}
