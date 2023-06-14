import 'package:http/http.dart' as http;
import 'dart:convert';

class PlugIn {
  PlugIn(this.url);

  final String url;
  // I plugIn to http to get the data
  
  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
