import 'package:http/http.dart' as http;

class Repository {
  final String _baseUrl = "coonch.com";
  final String _subUrl = "admin/api";
  //var _headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "application/json"};

  httpGet(String api) async {
    return await http.get(Uri.https(_baseUrl, "$_subUrl/$api"));
  }

  httpGetById(String api, id) async {
    return await http.get(Uri.https(_baseUrl, "$_subUrl/$api/$id"));
  }

  httpPost(String api, data) async {
    return await http.post(Uri.parse("https://$_baseUrl/$_subUrl/$api"),
        body: data);
  }
}
