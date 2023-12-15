enum SpaceAuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

extension AuthenticationStatusExtension on SpaceAuthenticationStatus {
  bool get isAuthenticated => this == SpaceAuthenticationStatus.authenticated;

  bool get isUnauthenticated =>
      this == SpaceAuthenticationStatus.unauthenticated;
}
