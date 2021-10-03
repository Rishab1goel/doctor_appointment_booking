import 'dart:developer';
import 'dart:io';

class NetworkConnection {
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      // print(result);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log('connected');
        return true;
      } else {
        log('not connected');
        return false;
      }
    } on SocketException catch (_) {
      log('not connected');
      return false;
    }
  }
}
