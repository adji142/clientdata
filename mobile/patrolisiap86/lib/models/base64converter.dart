import 'dart:convert';

import 'package:http/http.dart' as http;

class Base64Converter {
  String? imageLink;
  Base64Converter(this.imageLink);

  Future<String> networkImageToBase64() async {
    // http.Response response = await http.get(Uri.parse(this.imageLink.toString()));
    // final bytes = response.bodyBytes;
    // return (bytes != null ? base64Encode(bytes) : null);
    var url = Uri.parse(this.imageLink.toString());
    final response = await http.get(url);
    return base64Encode(response.bodyBytes);
  }
}
