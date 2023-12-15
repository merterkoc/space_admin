import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:space_admin/core/dio/dio_client.dart';
import 'package:space_admin/core/dio/response_entity.dart';
import 'package:space_admin/core/storage/secure_storage.dart';
import 'package:space_admin/src/constant/http_constants.dart';
import 'package:space_admin/src/login/model/enum/authentication_status.dart';
import 'package:space_admin/src/repository/model/dto/login_dto.dart';

class AuthenticationRepository {
  Stream<SpaceAuthenticationStatus> get authenticationStatus {
    return dioClient.authenticationStatus.map(
      (status) {
        switch (status) {
          case AuthenticationStatus.authenticated:
            return SpaceAuthenticationStatus.authenticated;
          case AuthenticationStatus.unauthenticated:
            return SpaceAuthenticationStatus.unauthenticated;
          case AuthenticationStatus.initial:
            return SpaceAuthenticationStatus.unknown;
        }
      },
    );
  }

  factory AuthenticationRepository() => _instance;

  static final AuthenticationRepository _instance =
      AuthenticationRepository._internal();

  AuthenticationRepository._internal();

  Future<ResponseEntity<String>> login(LoginDTO loginDTO) async {
    try {
      final response = await dioClient.post(
        HTTPConstants.loginPath,
        loginDTO.toJson(),
      );
      if (response.statusCode == 200 && response.data != null) {
        final token =
            secureTokenStorage.jsonToToken(response.data) as OAuth2Token;
        await dioClient.saveToken(token);
      }
      return ResponseEntity<String>(
        statusCode: response.statusCode ?? -1,
        message: response.statusMessage,
      );
    } on DioException catch (e) {
      return ResponseEntity<String>(
        statusCode: e.response?.statusCode ?? -1,
        message: e.toString(),
      );
    }
  }

  void logout() {
    dioClient.unAuthenticate();
    dioClient.deleteToken();
  }
}
