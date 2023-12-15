enum PageState {
  idle,
  loading,
  success,
  error,
  empty,
  noInternet,
}

extension PageStateExtension on PageState {
  bool get isIdle => this == PageState.idle;

  bool get isLoading => this == PageState.loading;

  bool get isSuccess => this == PageState.success;

  bool get isError => this == PageState.error;

  bool get isEmpty => this == PageState.empty;

  bool get isNoInternet => this == PageState.noInternet;
}
