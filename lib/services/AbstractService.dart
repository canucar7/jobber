abstract class AbstractService {
  String apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1";
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