class HTTPConstants {
  const HTTPConstants._();

  static const String baseUrl = "https://space-backend-79fa.globeapp.dev";

  static const Duration connectTimeout = Duration(milliseconds: 50000);

  static const Duration receiveTimeout = Duration(milliseconds: 50000);

  static const String eventPath = "/api/admin/event";

  static const String loginPath = "/api/identity/login";
}
