import 'package:get/get.dart';

class ApiServices extends GetConnect {
  Map<String, String> header = {'Content-Type': 'application/json'};

  Future<dynamic> getApi({required String url}) async {
    var jsonResponse;
    try {
      Response response = await get(url);
      if (response.isOk) {
        jsonResponse = response.body;
      }
    } catch (err) {
      print(err);
    }
    return jsonResponse;
  }

  Future<dynamic> postApi(
      {required String url, required Map<String, dynamic> jsonBody}) async {
    var jsonResponse;
    try {
      Response response = await post(url, jsonBody, headers: header);
      if (response.isOk) {
        jsonResponse = response.body;
      }
    } catch (err) {
      print(err);
    }
    return jsonResponse;
  }

  Future<dynamic> putApi(
      {required String url, required Map<String, dynamic> jsonBody}) async {
    var jsonResponse;
    try {
      Response response = await put(
          url, jsonBody,
          headers: header);

      if (response.isOk) {
        jsonResponse = response.body;
      }
    } catch (err) {
      print(err);
    }
    return jsonResponse;
  }
}
