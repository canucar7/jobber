import 'package:jobfinder/config.dart';

abstract class AbstractService {
  String apiUrl = Config.apiUrl;
  final headers = {
    'Content-Type': 'application/json',
  };

  int? userId;

  AbstractService({token, this.userId}) {
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
  }
}