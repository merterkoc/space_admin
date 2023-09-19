class HTTPConstants {
  const HTTPConstants._();

  static const String baseUrl = "http://localhost:8080";

  static const Duration connectTimeout = Duration(milliseconds: 50000);

  static const Duration receiveTimeout = Duration(milliseconds: 50000);

  static const String eventPath = "/api/admin/event";
}
