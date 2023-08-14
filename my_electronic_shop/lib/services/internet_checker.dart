import 'dart:io';

class CheckInternetConnection {
  
  Future<bool?> getInternetStatus() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
    return null;
  }

}